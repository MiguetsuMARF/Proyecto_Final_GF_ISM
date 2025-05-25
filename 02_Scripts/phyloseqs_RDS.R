library(phyloseq)

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
