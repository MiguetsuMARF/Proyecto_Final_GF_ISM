library(vegan)
library(phyloseq)

ps_parasitos<- list(ps_control, ps_haplorchis, ps_ascaris, ps_opisthorchis, ps_trichuris,
                    ps_ancilostoma, ps_necator, ps_taenia, ps_plasmodium, ps_schistosoma,
                    ps_ancilostoma3, ps_ascaris2, ps_ancylostoma2)


diversidades_parasito <- function(lista_phyloseq) {
  resultados <- data.frame(
    ID = character(),
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
    shannon <- diversity(otu, index = "shannon")
    SS <- specnumber(otu)
    sh_norm <- mean(shannon / log(SS), na.rm = TRUE)
    simpson <- mean(diversity(otu, index = "simpson"))
    sh_norm<- mean(shannon/log(SS))
    shannon_media <- mean(shannon, na.rm = TRUE)
    simpson_media <- mean(diversity(otu, index = "simpson"), na.rm = TRUE)
    
    
    resultados <- rbind(resultados, data.frame(
      ID = names(lista_phyloseq)[i],
      Shannon = shannon_media,
      Simpson = simpson_media,
      Sh_normalizado = sh_norm
    ))
  }
  
  return(resultados)
}

#Un trial run a ver qpd
prueba1<- list(phylo_ancylostoma,phylo_ascaris)

names(prueba1) <- paste0("phylo", seq_along(prueba1))

names(prueba1)
diversidades_parasito(prueba1)


#Ahora sí 

names(ps_parasitos)<- c("ps_control", "ps_haplorchis", "ps_ascaris", "ps_opisthorchis",
                        "ps_trichuris", "ps_ancilostoma", "ps_necator", "ps_taenia",
                        "ps_plasmodium", "ps_schistosoma",
                        "ps_ancilostoma3", "ps_ascaris2", "ps_ancylostoma2")
df_diversidades<-diversidades_parasito(ps_parasitos)

diversidades_num<- df_diversidades[,-1]
diversidades_num
ID<-df_diversidades$ID


diversidistancias<-(dist(diversidades_num, method = "euclidean"))

diversidistancias<-as.matrix(diversidistancias)

rownames(diversidistancias)<- ID
colnames(diversidistancias)<-ID

library(igraph)

umbral<- 1.5
diversifiltro<- diversidistancias < umbral

rownames(diversifiltro) <- rownames(diversidistancias)
colnames(diversifiltro)<- colnames(diversidistancias)
red_diversidades<-graph_from_adjacency_matrix(diversifiltro, mode = "undirected",
                                              diag = FALSE)

V(red_diversidades)$name
V(red_diversidades)$name<- rownames(diversifiltro)

plot(red_diversidades)
