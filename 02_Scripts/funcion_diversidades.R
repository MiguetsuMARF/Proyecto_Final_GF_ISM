library(vegan)
library(phyloseq)




diversidades_parasito <- function(lista_phyloseq) {
  resultados <- data.frame(
    ID = character(),
    Shannon = numeric(),
    Simpson = numeric(),
    Chao1 = numeric(),
    stringsAsFactors = FALSE
  )
  
  for (i in 1:length(lista_phyloseq)) {
    ps <- lista_phyloseq[[i]]
    otu <- as.matrix(otu_table(ps))
    
    if (taxa_are_rows(ps)) {
      otu <- t(otu)
    }
    
    shannon <- mean(diversity(otu, index = "shannon"))
    simpson <- mean(diversity(otu, index = "simpson"))
    
    estimadores <- estimateR(otu)
    if ("Chao1" %in% rownames(estimadores)) {
      chao1 <- mean(estimadores["Chao1", ])
    } else {
      chao1 <- NA
    }
    
    resultados <- rbind(resultados, data.frame(
      ID = names(lista_phyloseq)[i],
      Shannon = shannon,
      Simpson = simpson,
      Chao1 = chao1
    ))
  }
  
  return(resultados)
}


prueba1<- list(phylo_ancylostoma,phylo_ascaris)

names(prueba1) <- paste0("phylo", seq_along(prueba1))

names(prueba1)
diversidades_parasito(prueba1)


