data <- read.csv("01_RowData/dataframe_final")
View(data)

rownames(data) <- data[,1]
data <- data[,-1]
dist(data)

data2 <- as.data.frame(sapply(data, as.numeric))

data2[is.na(data2)] <- 0

sum(is.na(data2))

rownames(data2) <- rownames(data) 

md <- as.matrix(dist(data2))

diag(md) <- 0
md
library(igraph)

matriz_adj <- (md> (0.675*mean(dist(data2))))
matriz_adj
coexpresion <- graph_from_adjacency_matrix(matriz_adj, mode = "undirected", diag = FALSE)
plot(coexpresion)

