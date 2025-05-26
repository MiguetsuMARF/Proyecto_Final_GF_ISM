             # Redes a partir de las caractersiticas de los parasitos #


library(igraph)

m_dist_DP2
str(m_dist_DP2)
# convertirla a matriz

mat_dist <- as.matrix(m_dist_DP2)

pdf("03_Results/heat_map_caracteristicas.pdf")
heatmap(mat_dist, main = "Matriz de distancias")
dev.off()

g_1 <- graph_from_adjacency_matrix(mat_dist, mode = "undirected", weighted = TRUE, diag = FALSE)


pdf("03_Results/Red_pesada_no_dirigida_caracteristicas.pdf")
plot(g_1,edge.size = 10,vertex.size=(eccentricity(g_1)^2), vertex.color = "beige", # el tamaño del nodo depende de la eccentricidad
     edge.color = "darkred",
     edge.width = (1 / E(g_1)$weight)^2*10,
     edge.arrow.size=0.1,layout=layout.fruchterman.reingold.grid,vertex.size.label=0.20)
dev.off()


plot(g_1,
     vertex.label = V(g_1)$name,
     edge.width = (1 / E(g_1)$weight)^2*10,  # menor distancia = mayor grosor
     edge.color = "darkred",
     vertex.color = "skyblue",
     layout = layout_with_fr(g_1))


heatmap(cor_matrix_DP2)

# ----------- medidas de centralidad ----------- #
degree(g_1)

betweenness(g_1)

transitivity(g_1, type = "local") # mide que tan conectados estan los vecinos
# En este caso opistohorchis y ancilostoma son los que tienen a los vecinos mejor conectados


mean_distance(g_1)

edge_density(g_1)

sort(eccentricity(g_1), decreasing = FALSE) # Plasmodium es el que esta más fuera del centro

sort(closeness(g_1), decreasing = TRUE) # El nodo que esta más cerca de los demas es Haplorchis



# ---------------- CLUSTERING --------------- #

walktrap.community(g_1) -> walktrap_g1
membership(walktrap_g1)
plot(g_1, vertex.color= membership(walktrap_g1),  edge.arrow.size=0.25)

infomap.community(g_1) -> infomap_g1
membership(infomap_g1)

# Las medidas de centralidad nos dan poca información cuando la red se hizo a partir
# de una matriz de distancias, ya que todos los nodos estan interconectados entre si,
# por lo tanto medidas como el degree o el betweenes son identicos, al igual que los
# metodos de clustering.


tkplot(g_1) # red interactiva


# ------------------------ RED BOULEANA ----------------------- #

mean(mat_dist) -> umbral # Usare este dato como ubral para determinar si estan o no conectados
umbral 

# Hare una mat bouleana
m_bouleana <- mat_dist < umbral # Es una matriz de distancias, entre más parecidas
# las muestras menor es su distancia, porlo tanto requerimos que la distancia sea menor al umbral
diag(m_bouleana) <- 0 


g_boul <- graph_from_adjacency_matrix(m_bouleana, mode = "undirected", diag = FALSE)


plot(g_boul,
     vertex.label = V(g_boul)$name,
     vertex.color = "darkgreen",
     layout = layout_with_fr(g_boul))

# ----------- medidas de centralidad ----------- #
degree(g_boul)

betweenness(g_boul)

transitivity(g_boul, type = "local") # mide que tan conectados estan los vecinos
# En este caso opistohorchis y ancilostoma son los que tienen a los vecinos mejor conectados


mean_distance(g_boul)

edge_density(g_boul)

sort(eccentricity(g_boul), decreasing = FALSE)

sort(closeness(g_boul), decreasing = TRUE)

components(g_boul)

# ---------------- CLUSTERING --------------- #

walktrap.community(g_boul) -> walktrap_g_boul
membership(walktrap_g_boul)
plot(g_boul,vertex.size=(degree(g_boul)^2*2),vertex.color= membership(walktrap_g_boul),  edge.arrow.size=0.25)  # va pa la expo


pdf("03_Results/Red_bouleana_caracteristicas.pdf")
plot(g_boul, vertex.color= membership(walktrap_g_boul),  edge.arrow.size=0.25)
dev.off()

infomap.community(g_boul) -> infomap_g_boul
membership(infomap_g_boul)
plot(g_boul, vertex.color= membership(infomap_g_boul),  edge.arrow.size=0.25)

cluster_edge_betweenness(g_boul) -> ceb_g_boul
membership(ceb_g_boul)
plot(g_boul, vertex.color= membership(ceb_g_boul),  edge.arrow.size=0.25)

tkplot(g_boul) # Es para la red interactiva
