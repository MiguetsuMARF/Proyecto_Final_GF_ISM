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

A <- bind_rows(A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13)

A <- A[,c("Parasito", setdiff(names(A), "Parasito"))]
A$Parasito

Final <- data.frame()  

a <- c("Haplorchis taichui", "Ancilostoma", "Ascaris", "Necator",
       "Opisthorchis", "Plasmodium", "Taenia Saginata", "Trichuris", "Control", "Schistosoma")

View(A)
write.csv(A, "01_RowData/dataframe")

for (i in 1:10) {
  b <- a[i]
  z <- A[A$Parasito == b, ]  
  f <- c() 
  for (u in 2:dim(A)[2]) {
    e <- mean(z[, u])  
    f <- c(f, e)        
  }
  fd <- as.data.frame(t(f)) 
  fd$Parasito <- b           
  Final <- bind_rows(Final, fd)  
}

rownames(Final) <- a
dim(Final)

View(Final)

Final <- Final[, c(ncol(Final), 1:(ncol(Final)-1))]
View(Final)

Final[is.na(Final)] <- 0


write.csv(Final, "01_RowData/dataframe_final")

