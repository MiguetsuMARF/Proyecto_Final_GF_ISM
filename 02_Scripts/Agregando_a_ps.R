#----------------------------------------------------------# Editando phyloseq #---------------------------------------------------------#

library(phyloseq)

psH1 <- readRDS("01_RowData/RDS_ps/ps_helmints")

psH2 <- readRDS("01_RowData/RDS_ps/ps_helmints2")

psP <- readRDS("01_RowData/RDS_ps/ps_plasmodium")

psC <- readRDS("01_RowData/RDS_ps/phyloseq_control.rds")

datosC <- as.data.frame(sample_data(psC))
datosC$Parasito <- rep("Control", dim(datosC)[1])
sample_data(psC) <- sample_data(datosC)

saveRDS(psC, "01_RowData/RDS_ps/ps_control")

View(otu_table(psP))
View(sample_data(psH1))

View(sample_data(psH2))

View(sample_data(psP))

View(sample_data(psC))

datos2 <- read.csv("01_RowData/journal.pntd.0010491.s002.xlsx - Supplmentary Table 1.csv")
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

saveRDS(psH1f, file = "01_RowData/RDS_ps/ps_helmintsF")

datosh1 <- sample_data(psH1f)
datosh1

datosh1[which(str_detect(datosh1$Parasito, "Al")),"Parasito"] <- "Ascaris"
datosh1[which(str_detect(datosh1$Parasito, "Ov")),"Parasito"] <- "Opisthorchis"
datosh1[which(str_detect(datosh1$Parasito, "Tt")),"Parasito"] <- "Trichuris"
datosh1[which(str_detect(datosh1$Parasito, "An")),"Parasito"] <- "Ancilostoma"
datosh1[which(str_detect(datosh1$Parasito, "Na")),"Parasito"] <- "Necator"
datosh1[which(str_detect(datosh1$Parasito, "Tsag")),"Parasito"] <- "Taenia Saginata"

sample_data(psH1f) <- sample_data(datosh1)

psH1fas <- subset_samples(psH1f, sample_data(psH1f)$Parasito == "Ascaris")
psH1fop <- subset_samples(psH1f, sample_data(psH1f)$Parasito == "Opisthorchis")
psH1ftr <- subset_samples(psH1f, sample_data(psH1f)$Parasito == "Trichuris")
psH1fan <- subset_samples(psH1f, sample_data(psH1f)$Parasito == "Ancilostoma")
psH1fne <- subset_samples(psH1f, sample_data(psH1f)$Parasito == "Necator")
psH1fta <- subset_samples(psH1f, sample_data(psH1f)$Parasito == "Taenia Saginata")
saveRDS(psH1fas, file = "01_RowData/RDS_ps/ps_ASCARIS")
saveRDS(psH1fop, file = "01_RowData/RDS_ps/ps_OPISTHORCHIS")
saveRDS(psH1ftr, file = "01_RowData/RDS_ps/ps_TRICHURIS")
saveRDS(psH1fan, file = "01_RowData/RDS_ps/ps_ANCILOSTOMA")
saveRDS(psH1fne, file = "01_RowData/RDS_ps/ps_NECATOR")
saveRDS(psH1fta, file = "01_RowData/RDS_ps/ps_TAENIA")

psH2f <- subset_samples(psH2, sample_data(psH2)$disease != "negative")

datosH2 <- as.data.frame(sample_data(psH2f))
datosH2$Parasito <- rep("Haplorchis taichui", dim(datosH2)[1])
sample_data(psH2f) <- sample_data(datosH2)

View(sample_data(psH2f))

saveRDS(psH2f, "01_RowData/RDS_ps/ps_Haplorchis")

ps_haplorchis <- readRDS("01_RowData/RDS_ps/ps_Haplorchis")

datos3 <- sample_data(psP)

datos3$Parasito <- rep("Plasmodium", dim(datos3)[1])

sample_data(psP) <- sample_data(datos3)

saveRDS(psP, "01_RowData/RDS_ps/ps_plasmodium")

A1 <- as.data.frame(otu_table(psH1f))
A2 <- as.data.frame(otu_table(psH2f))
A3 <- as.data.frame(otu_table(psP))

library(tidyverse)

A <- bind_rows(A1,A2,A3)

A <- A[,c("Parasito", setdiff(names(A), "Parasito"))]

A[is.na(A)] <- 0