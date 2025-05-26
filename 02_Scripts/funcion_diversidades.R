library(vegan)
library(phyloseq)

#Una lista de los phyloseqs que tenemos

ps_parasitos<- list(ps_control, ps_haplorchis, ps_ascaris, ps_opisthorchis, ps_trichuris,
                    ps_ancilostoma, ps_necator, ps_taenia, ps_plasmodium, ps_schistosoma,
                    ps_ancilostoma3, ps_ascaris2, ps_ancylostoma2)

#Va la función que calcula las diversidades de simpson, shannon y shannon normalizado
#Para cada phyloseq 

diversidades_parasito <- function(lista_phyloseq) {
  resultados <- data.frame(
    Parasito = character(),
    Shannon = numeric(),
    Simpson = numeric(),
    Sh_normalizado = numeric(),
    stringsAsFactors = FALSE
  )
  
  for (i in 1:length(lista_phyloseq)) {
    ps <- lista_phyloseq[[i]]
    otu <- as.matrix(otu_table(ps))
    
    if (taxa_are_rows(ps)) {
      otu <- t(otu)
    }
    
    shannon <- vegan::diversity(otu, index = "shannon")
    SS <- vegan::specnumber(otu)
    simpson <- vegan::diversity(otu, index = "simpson")
    
    shannon_media <- mean(shannon, na.rm = TRUE)
    simpson_media <- mean(simpson, na.rm = TRUE)
    sh_norm <- mean(shannon / log(SS), na.rm = TRUE)
    
    resultados <- rbind(resultados, data.frame(
      Parasito = names(lista_phyloseq)[i],
      Shannon = shannon_media,
      Simpson = simpson_media,
      Sh_normalizado = sh_norm
    ))
  }
  
  return(resultados)
}

#Un trial run a ver si funcionaba
prueba1<- list(phylo_ancylostoma,phylo_ascaris)

names(prueba1) <- paste0("phylo", seq_along(prueba1))

names(prueba1)
diversidades_parasito(prueba1)


#Ahora sí, con el bueno, pero igual que con el trial, hay que agregarle 
#Nombres porque si no, no hace nadota

names(ps_parasitos)<- c("ps_control", "ps_haplorchis", "ps_ascaris", "ps_opisthorchis",
                        "ps_trichuris", "ps_ancilostoma", "ps_necator", "ps_taenia",
                        "ps_plasmodium", "ps_schistosoma",
                        "ps_ancilostoma3", "ps_ascaris2", "ps_ancylostoma2")
#Guardando el dataframe en un objeto para hacer los análisis después
df_diversidades<-diversidades_parasito(ps_parasitos)

diversidades_parasito(ps_parasitos)

#Quitando la columna ID
diversidades_num<- df_diversidades[,-1]
diversidades_num


#Ya se que parece tonto, pero no encontré otra forma
ID<-df_diversidades$Parasito


#Podría ser con otro método 
diversidistancias<-(dist(diversidades_num, method = "euclidean"))

diversidistancias<-as.matrix(diversidistancias)

#Para que los nodos acaben teniendo nombre, luego se ve por qué empecé de acá
rownames(diversidistancias)<- ID
colnames(diversidistancias)<-ID

library(igraph)
#Es para que las conexiones solo aparezcan si son con un valor mayor al promedio
#de la matriz, pero pues sigue siendo algo arbitrario 

umbral<- 0.5*mean(diversidistancias)
diversifiltro<- diversidistancias < umbral #Filtrando por el umbral

#Para que los nodos tengan nombre 
rownames(diversifiltro) <- rownames(diversidistancias)
colnames(diversifiltro)<- colnames(diversidistancias)
#Ahora sí creo la red
red_diversidades<-graph_from_adjacency_matrix(diversifiltro, mode = "undirected",
                                              diag = FALSE)
#Agregándole los nombres, no sé qué tan necesario era este paso, pero lo hice
#antes de resolver cómo hacerlo bien y ya no le quise move nada
V(red_diversidades)$name
V(red_diversidades)$name<- rownames(diversifiltro)

# CLUSTERIZAR   
optimal <- cluster_optimal(red_diversidades)
plot(red_diversidades, vertex.color=membership(optimal))

pdf("03_Results/red_diversidades")
plot(red_diversidades) #No se ve ningún resutlado coherente.
dev.off()

#Ahora voy a hacer ANOVAs

df_anova<- df_diversidades[-1,]
df_anova$tipo_parasito<- c("trematodo", "nematodo", "trematodo", "nematodo",
                                  "nematodo", "nematodo", "cestodo",
                                  "apicomplexo", "trematodo", "nematodo", "nematodo",
                                  "nematodo")

Shannova<-aov(Shannon~tipo_parasito, data = df_anova)
summary(Shannova)
TukeyHSD(Shannova)

df_anova$nicho<- c("intestino_delgado", "intestino_delgado", "conductos_biliares"
                   , "colon", "intestino_delgado", "", "", "", "", "")

parasinoba <- aov(Shannon ~ Parasito, df_anova)
summary.aov(parasinoba)
TukeyHSD(parasinoba)
