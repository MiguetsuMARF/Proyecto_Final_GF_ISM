             # Redes a partir de las caractersiticas de los parasitos #


library(igraph)

m_dist_DP2
str(m_dist_DP2)
# convertirla a matriz

mat_dist <- as.matrix(m_dist_DP2)

g_1 <- graph_from_adjacency_matrix(mat_dist, mode = "undirected", weighted = TRUE, diag = FALSE)

plot(g_1,edge.size = 10,vertex.size=(eccentricity(g_1)^2), vertex.color = "beige", # el tamaño del nodo depende de la eccentricidad
     edge.color = "darkred",
     edge.width = (1 / E(g_1)$weight)^2*10,
     edge.arrow.size=0.1,layout=layout.fruchterman.reingold.grid,vertex.size.label=0.20)


plot(g_1,
     vertex.label = V(g_1)$name,
     edge.width = (1 / E(g_1)$weight)^2*10,  # menor distancia = mayor grosor
     edge.color = "darkred",
     vertex.color = "skyblue",
     layout = layout_with_fr(g_1))


heatmap(cor_matrix_DP2)

#-----#

degree(g_1)
betweenness(g_1)

sort(eccentricity(g_1), decreasing = FALSE)

sort(closeness(g_1), decreasing = TRUE)

walktrap.community(g_1) -> walktrap_g1
membership(walktrap_g1)
plot(g_1, vertex.color= membership(walktrap_g1),  edge.arrow.size=0.25)

infomap.community(g_1) -> infomap_g1
membership(infomap_g1)

# Todo esta de la verga si es no dirigida.
# Todos estan conectados y la distancia depende de que tan parecidos
# o que tan diferentes son.


mean(mat_dist) -> umbral # Usare este dato como ubral para determinar si estan o no conectados
umbral 

# Hare una mat bouleana
m_bouleana <- mat_dist < umbral
diag(m_bouleana) <- 0 


g_boul <- graph_from_adjacency_matrix(m_bouleana, mode = "undirected", diag = FALSE)


plot(g_boul,
     vertex.label = V(g_boul)$name,
     vertex.color = "darkgreen",
     layout = layout_with_fr(g_boul))

# medidas de centralidad
degree(g_boul)
betweenness(g_boul)

sort(eccentricity(g_boul), decreasing = FALSE)

sort(closeness(g_boul), decreasing = TRUE)

walktrap.community(g_boul) -> walktrap_g_boul
membership(walktrap_g_boul)
plot(g_boul, vertex.color= membership(walktrap_g_boul),  edge.arrow.size=0.25)

infomap.community(g_boul) -> infomap_g_boul
membership(infomap_g_boul)
plot(g_boul, vertex.color= membership(infomap_g_boul),  edge.arrow.size=0.25)

cluster_edge_betweenness(g_boul) -> ceb_g_boul
membership(ceb_g_boul)
plot(g_boul, vertex.color= membership(ceb_g_boul),  edge.arrow.size=0.25)

