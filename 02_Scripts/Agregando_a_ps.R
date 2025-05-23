#----------------------------------------------------------# Editando phyloseq #---------------------------------------------------------#

library(phyloseq)

psH1 <- readRDS("01_RowData/RDS_ps/ps_helmints")

psH2 <- readRDS("01_RowData/RDS_ps/ps_helmints2")

psP <- readRDS("01_RowData/RDS_ps/ps_plasmodium")

View(sample_data(psH1))

View(sample_data(psH2))

View(sample_data(psP))

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
