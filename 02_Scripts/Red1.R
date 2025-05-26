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

matriz_adj <- (md< (0.5*mean(dist(data2))))
matriz_adj
coexpresion <- graph_from_adjacency_matrix(matriz_adj, mode = "undirected", diag = FALSE)
plot(coexpresion)

mc <- cor(t(as.matrix(data2)))
diag(mc) <- 0

matriz_adj2 <- (mc < (0.1))
coexpresion2 <- graph_from_adjacency_matrix(matriz_adj2, mode = "undirected", diag = FALSE)
plot(coexpresion2)

pdf("03_Results/red_abundancias_dist.pdf")
optimal <- cluster_optimal(coexpresion)
plot(coexpresion, vertex.color=membership(optimal))
dev.off()

walktrap2 <- cluster_walktrap(coexpresion2)
plot(coexpresion2, vertex.color=membership(walktrap2))

pdf("03_Results/red_abundancias_cor.pdf")
optimal2 <- cluster_optimal(coexpresion2)
plot(coexpresion2, vertex.color=membership(optimal2))
dev.off()

