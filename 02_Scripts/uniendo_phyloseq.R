ps_haplorchis <- readRDS("01_RowData/RDS_ps/ps_Haplorchis") ## Columna Parasito en sample_data

ps_ascaris <- readRDS("01_RowData/RDS_ps/ps_ASCARIS") ## Columna Parasito en sample_data

ps_opisthorchis <- readRDS("01_RowData/RDS_ps/ps_OPISTHORCHIS") ## Columna Parasito en sample_data

ps_trichuris <- readRDS("01_RowData/RDS_ps/ps_TRICHURIS") ## Columna Parasito en sample_data

ps_ancilostoma <- readRDS("01_RowData/RDS_ps/ps_ANCILOSTOMA") ## Columna Parasito en sample_data

ps_necator <- readRDS("01_RowData/RDS_ps/ps_NECATOR") ## Columna Parasito en sample_data

ps_taenia <- readRDS("01_RowData/RDS_ps/ps_TAENIA") ## Columna Parasito en sample_data

ps_plasmodium <- readRDS("01_RowData/RDS_ps/ps_plasmodium") ## Columna Parasito en sample_data

ps_control <- readRDS("01_RowData/RDS_ps/ps_control")

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

A1