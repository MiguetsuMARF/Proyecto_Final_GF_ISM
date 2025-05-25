library(phyloseq)

phylo_nematodos<- readRDS("FASTQ/PhyloseqNematodos")

phylo_ascaris<- readRDS("FASTQ/Phyloseq_ascaris")

phylo_ancylostoma<- readRDS("FASTQ/phyloseq_ancylostoma")


plot_richness(phylo_ascaris)

View(tax_table(phylo_ascaris))
View(otu_table(phylo_ascaris))

B1 <- as.data.frame(otu_table(phylo_ascaris))
B2 <- as.data.frame(otu_table(phylo_ancylostoma))

B <- bind_rows(B1, B2)
dim(B)

B <- B[,c("Parasito", setdiff(names(B), "Parasito"))]
