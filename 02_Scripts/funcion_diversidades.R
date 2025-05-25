diversidades_parasitos <- function(vector_phyloseqs_varios) {
  resultados <- data.frame(
    ID = character(),
    Shannon = numeric(),
    Simpson = numeric(),
    Chao = numeric()
  )
  for (i in 1:lenght(vector_phyloseqs_varios)) {
    ps <- vector_phyloseqs_varios[[i]]
    otu <- as.matrix(otu_table(ps))
    if (taxa_are_rows(ps)) {
      otu <- t(otu)
    }
    
    shannon <- mean(diversity(otu, index = "shannon"))
    simpson <- mean(diversity(otu, index = "simpson"))
    chao <- mean(estimateR(otu)["Chao", ])
    
    resultados <- rbind(resultados, data.frame(
      ID = names(lista_phyloseq)[i],
      Shannon = shannon,
      Simpson = simpson,
      Chao = chao
    ))
  }
  
  return(resultados)
}