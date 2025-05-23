#----------------------------------------------------------# Editando phyloseq #---------------------------------------------------------#

library(phyloseq)

psH1 <- readRDS("01_RowData/RDS_ps/ps_helmints")

psH2 <- readRDS("01_RowData/RDS_ps/ps_helmints2")

psP <- readRDS("01_RowData/RDS_ps/ps_plasmodium")

psC <- readRDS("01_RowData/RDS_ps/phyloseq_control.rds")


View(sample_data(psH1))

View(sample_data(psH2))

View(sample_data(psP))

View(sample_data(psC))

datos2 <- read.csv("../../journal.pntd.0010491.s002.xlsx - Supplmentary Table 1.csv")
View(datos2)
datos2[,11]

rownames(datos2) <- datos2$Sample.id

psH1_meta <- sample_data(psH1)
psH1_meta1 <- list()
psH1_meta1$"SampleName" <- psH1_meta[,"Sample.Name"]
psH1_meta1$"SampleName2" <- c(datos2$Sample.id,0,0)
psH1_meta1$"Ordenado" <- c(rep(0, 93))
psH1_meta1$"Ordenado2" <- c(rep(0, 93))
psH1_meta1

dim(datos2)
dim(psH1_meta)

v <- c(psH1_meta1$SampleName2)

library(stringr)

for (i in 1:93) {
  a <- as.character(psH1_meta1$SampleName[i]) 
  psH1_meta1$"Ordenado"[which(str_detect(psH1_meta1$SampleName2, a))] <- row.names(psH1_meta1$SampleName[i])
}

x <- 0
for (i in 1:93) {
  a <- as.character(psH1_meta1$SampleName[i]) 
  if (all((psH1_meta1$Ordenado == rownames(psH1_meta1$SampleName[i])) == FALSE)){
    x <- x + 1
  } else{
  psH1_meta1$Ordenado2[which(psH1_meta1$SampleName == a)] <- v[which(str_detect(psH1_meta1$SampleName2, a))]
  }
}
psH1_meta1

nueva <- data.frame(
  Parasitos = c(rep(0, 93)),
  Sample = c(rep(0, 93))
)
for (i in 1:93) {
  if (psH1_meta1$Ordenado2[i] == 0){
    x <- x + 1
  } else {
    nueva$Parasitos[i] <- datos2$Groups.by.PCR.or.KK[which(datos2$Sample.id == psH1_meta1$Ordenado2[i])]
    nueva$Sample[i] <- datos2$Sample.id[which(datos2$Sample.id == psH1_meta1$Ordenado2[i])]
  }
}

nueva
nueva2 <- as.data.frame(sample_data(psH1))
all(rownames(nueva2) == rownames(nueva))

row.names(nueva) <- row.names(nueva2)
nueva2$Parasito <- nueva[,1]
nueva2$Sample <- nueva[,2]
nueva2
sample_data(psH1) <- sample_data(nueva2)

View(sample_data(psH1))

psH1f <- subset_samples(psH1, sample_data(psH1)$Parasito != 0 & sample_data(psH1)$Parasito != "NA")
View(sample_data(psH1f))

psH2f <- subset_samples(psH2, sample_data(psH2)$disease != "negative")
View(sample_data(psH2f))

A1 <- as.data.frame(otu_table(psH1f))
A2 <- as.data.frame(otu_table(psH2f))
A3 <- as.data.frame(otu_table(psP))

A1$Parasito <- sample_data(psH1f)$Parasito
A2$Parasito <- sample_data(psH2f)$disease
A3$Parasito <- rep("Plasmodium", dim(A3)[1])






View(A3)

library(tidyverse)

A <- bind_rows(A1,A2,A3)

dim(A)

A <- A[,c("Parasito", setdiff(names(A), "Parasito"))]

View(A)

A[is.na(A)] <- 0

A$Parasito
A[which(str_detect(A$Parasito, "Al")),1] <- "Ascaris"
A[which(str_detect(A$Parasito, "Ov")),1] <- "Opisthorchis"
A[which(str_detect(A$Parasito, "Tt")),1] <- "Trichuris"
A[which(str_detect(A$Parasito, "An")),1] <- "Ancilostoma"
A[which(str_detect(A$Parasito, "Na")),1] <- "Necator"
A[which(str_detect(A$Parasito, "Tsag")),1] <- "Taenia Saginata"
A[which(str_detect(A$Parasito, "Haplorchis")),1] <- "Haplorchis taichui"
