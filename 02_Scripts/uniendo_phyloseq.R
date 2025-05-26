## -------------------------- Uniendo phyloseqs ---------------------------- ##

## Todos estos phyloseq ya fueron anteriormente filtrados y editados para contener la columna Parasito en sample_data

ps_haplorchis <- readRDS("01_RowData/RDS_ps/ps_Haplorchis") ## Columna Parasito en sample_data

ps_ascaris <- readRDS("01_RowData/RDS_ps/ps_ASCARIS") ## Columna Parasito en sample_data

ps_opisthorchis <- readRDS("01_RowData/RDS_ps/ps_OPISTHORCHIS") ## Columna Parasito en sample_data

ps_trichuris <- readRDS("01_RowData/RDS_ps/ps_TRICHURIS") ## Columna Parasito en sample_data

ps_ancilostoma <- readRDS("01_RowData/RDS_ps/ps_ANCILOSTOMA") ## Columna Parasito en sample_data

ps_necator <- readRDS("01_RowData/RDS_ps/ps_NECATOR") ## Columna Parasito en sample_data

ps_taenia <- readRDS("01_RowData/RDS_ps/ps_TAENIA") ## Columna Parasito en sample_data

ps_plasmodium <- readRDS("01_RowData/RDS_ps/ps_plasmodium") ## Columna Parasito en sample_data

ps_control <- readRDS("01_RowData/RDS_ps/ps_control")

ps_schistosoma <- readRDS("01_RowData/RDS_ps/ps_schistosoma")

ps_ancilostoma3 <- readRDS("01_RowData/RDS_ps/ps_ancylostoma3")  # Columna parasito en sample_data

ps_ascaris2 <- readRDS("01_RowData/RDS_ps/ps_ascaris2") # Columna parasito en sample_data

ps_ancylostoma2 <- readRDS("01_RowData/RDS_ps/ps_ancylostoma2") # Columna parasito en sample_data

library(phyloseq)

# primero debemos extraer las otu_table con las abundancias como dataframe de cada phyloseq.
A1 <- as.data.frame(otu_table(ps_haplorchis))
A2 <- as.data.frame(otu_table(ps_ancilostoma))
A3 <- as.data.frame(otu_table(ps_ascaris))
A4 <- as.data.frame(otu_table(ps_necator))
A5 <- as.data.frame(otu_table(ps_opisthorchis))
A6 <- as.data.frame(otu_table(ps_plasmodium))
A7 <- as.data.frame(otu_table(ps_taenia))
A8 <- as.data.frame(otu_table(ps_trichuris))
A9 <- as.data.frame(otu_table(ps_control))
A10 <- as.data.frame(otu_table(ps_schistosoma))
A11 <- as.data.frame(otu_table(ps_ancilostoma3))
A12 <- as.data.frame(otu_table(ps_ascaris2))
A13 <- as.data.frame(otu_table(ps_ancylostoma2))

# Posteriormente debemos de extraer la columna parasito de los metadatos y agregarla las bases de datos individuales.
A1$Parasito <- sample_data(ps_haplorchis)$Parasito
A2$Parasito <- sample_data(ps_ancilostoma)$Parasito
A3$Parasito <- sample_data(ps_ascaris)$Parasito
A4$Parasito <- sample_data(ps_necator)$Parasito
A5$Parasito <- sample_data(ps_opisthorchis)$Parasito
A6$Parasito <- sample_data(ps_plasmodium)$Parasito
A7$Parasito <- sample_data(ps_taenia)$Parasito
A8$Parasito <- sample_data(ps_trichuris)$Parasito
A9$Parasito <- sample_data(ps_control)$Parasito
A10$Parasito <- sample_data(ps_schistosoma)$Parasito
A11$Parasito <- sample_data(ps_ancilostoma3)$Parasito
A12$Parasito <- sample_data(ps_ascaris2)$Parasito
A13$Parasito <- sample_data(ps_ancylostoma2)$Parasito

library(tidyverse)

# Con la funcion bind rows unimos todos los phyloseq, manteniendo los ASV especificos de cada uno.
A <- bind_rows(A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13)

# Con esta funcion reacomodamos la base de datos para que la primer columna sea Parasito, por motivos esteticos.
A <- A[,c("Parasito", setdiff(names(A), "Parasito"))]
A$Parasito

# Ahora vamos a promediar las abundancias por ASV filtrando por tipo de parasito

# creamos una base de datos vacia.
Final <- data.frame()  

# creamos un vector que tenga todos los posibles valores de la variable parasito.
a <- c("Haplorchis taichui", "Ancilostoma", "Ascaris", "Necator",
       "Opisthorchis", "Plasmodium", "Taenia Saginata", "Trichuris", "Control", "Schistosoma")

View(A)
write.csv(A, "01_RowData/dataframe")

# Hacemos un ciclo for que haga el calculo
for (i in 1:10) { # va de 1 al numero de posibles valores, osea la length(a)
  b <- a[i] # extraemos el valor que estamos trabajando en el ciclo y lo asignamos como b
  z <- A[A$Parasito == b, ]  # filtramos la base de datos A para todos aquellos que tienen el valor b en parasito
  f <- c() # creamos un vector vacio 
  for (u in 2:dim(A)[2]) { # hacemos un segundo ciclo que va de 1 hasta el numero de asv presentes en la base de datos.
    e <- mean(z[, u]) # sacamos el promedio de la base de datos filtrada z del ASV seleccionado en este ciclo
    f <- c(f, e) # Vamos rellenando el vector vacio con los valores en orden de los promedio de ASV       
  }
  fd <- as.data.frame(t(f)) # Una vez termino el ciclo tendremos un vector que contiene los valores precisos de cada media de cada ASV.
  fd$Parasito <- b  # Asignamos el valor del parasito evaluado         
  Final <- bind_rows(Final, fd)  # usamos bind rows para unir el vector como data frame con los generados en ciclos anteriores.
}

rownames(Final) <- a # asignamos los rownames
dim(Final)

View(Final)

Final <- Final[, c(ncol(Final), 1:(ncol(Final)-1))] # re ordenamos la base de datos
View(Final)

Final[is.na(Final)] <- 0 # si algun valor durante el bind rows se asigno como NA por defecto ya que no existia valor para ese ASV en el otu_table original se sustituye por 0


write.csv(Final, "01_RowData/dataframe_final")

