library(phyloseq)

phylo_ascaris<- readRDS("FASTQ/Phyloseq_ascaris")

phylo_ancylostoma<- readRDS("FASTQ/phyloseq_ancylostoma")

library(phyloseq)
library(Biostrings)

dna <- Biostrings::DNAStringSet(taxa_names(phylo_ascaris))
names(dna) <- taxa_names(phylo_ascaris)
phylo_ascaris <- merge_phyloseq(phylo_ascaris, dna)
taxa_names(phylo_ascaris) <- paste0("ASV", seq(ntaxa(phylo_ascaris)))

View(otu_table(phylo_ascaris))

datosas <- as.data.frame(sample_data(phylo_ascaris))
datosas$Parasito <- rep("Ascaris", dim(datosas)[1])
sample_data(phylo_ascaris) <- sample_data(datosas)

saveRDS(phylo_ascaris, "01_RowData/RDS_ps/ps_ascaris2")

dna <- Biostrings::DNAStringSet(taxa_names(phylo_ancylostoma))
names(dna) <- taxa_names(phylo_ancylostoma)
phylo_ancylostoma <- merge_phyloseq(phylo_ancylostoma, dna)
taxa_names(phylo_ancylostoma) <- paste0("ASV", seq(ntaxa(phylo_ancylostoma)))

View(otu_table(phylo_ancylostoma))

datosan <- as.data.frame(sample_data(phylo_ancylostoma))
datosan$Parasito <- rep("Ancilostoma", dim(datosan)[1])
sample_data(phylo_ancylostoma) <- sample_data(datosan)

saveRDS(phylo_ancylostoma, "01_RowData/RDS_ps/ps_ancylostoma2")

View(sample_data(phylo_nematodos))
View(sample_data(phylo_ascaris))
View(sample_data(phylo_ascaris))

ps_ancilostoma_extra <- readRDS("01_RowData/RDS_ps/ps_ancilostoma_limpio.rds") 

dna <- Biostrings::DNAStringSet(taxa_names(ps_ancilostoma_extra))
names(dna) <- taxa_names(ps_ancilostoma_extra)
ps_ancilostoma_extra <- merge_phyloseq(ps_ancilostoma_extra, dna)
taxa_names(ps_ancilostoma_extra) <- paste0("ASV", seq(ntaxa(ps_ancilostoma_extra)))

View(otu_table(ps_ancilostoma_extra))

datosan2 <- as.data.frame(sample_data(ps_ancilostoma_extra))
datosan2$Parasito <- rep("Ancilostoma", dim(datosan2)[1])
sample_data(ps_ancilostoma_extra) <- sample_data(datosan2)

saveRDS(ps_ancilostoma_extra, "01_RowData/RDS_ps/ps_ancylostoma3")
