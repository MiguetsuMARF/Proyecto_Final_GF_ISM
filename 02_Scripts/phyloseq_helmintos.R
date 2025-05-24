library(dada2)
library(phyloseq)

path <- "../../fastq_files"

fnFs <- sort(list.files(path, pattern="_1.fastq", full.names = TRUE))
fnRs <- sort(list.files(path, pattern="_2.fastq", full.names = TRUE))

sample.names <- sapply(strsplit(basename(fnFs), "_"), `[`, 1)
sample.names

filtFs <- file.path(path, "filtered", paste0(sample.names, "_F_filt.fastq.gz"))
filtRs <- file.path(path, "filtered", paste0(sample.names, "_R_filt.fastq.gz"))
names(filtFs) <- sample.names
names(filtRs) <- sample.names

out <- filterAndTrim(fnFs, filtFs, fnRs, filtRs, truncLen=c(240,160),
                     maxN=0, maxEE=c(2,2), truncQ=2, rm.phix=TRUE,
                     compress=TRUE) 
errF <- learnErrors(filtFs)

errR <- learnErrors(filtRs)

dadaFs <- dada(filtFs, err=errF)
dadaRs <- dada(filtRs, err=errR)


mergers <- mergePairs(dadaFs, filtFs, dadaRs, filtRs, verbose=TRUE)
seqtab <- makeSequenceTable(mergers)
seqtab.nochim <- removeBimeraDenovo(seqtab, method="consensus", verbose=TRUE)
rownames(seqtab.nochim) <- sample.names
sum(seqtab.nochim)/sum(seqtab)

getN <- function(x) sum(getUniques(x))
track <- cbind(out, sapply(dadaFs, getN), sapply(dadaRs, getN), sapply(mergers, getN), rowSums(seqtab.nochim))
colnames(track) <- c("input", "filtered", "denoisedF", "denoisedR", "merged", "nonchim")
rownames(track) <- sample.names
head(track)
taxa <- assignTaxonomy(seqtab.nochim, "../Genomica_Funcional_MARF_2025-1/Dada2/Ejercicio_1/01_Raw_Data/silva_nr99_v138.2_toGenus_trainset (1).fa.gz")
taxa.print <- taxa
rownames(taxa.print) <- NULL
head(taxa.print)

library(phyloseq)
library(Biostrings)
library(ggplot2)
theme_set(theme_bw())

sample_metadata <- read.csv("../../SraRunTable.csv", row.names=1)
samp <- sample_data(sample_metadata)

ps <- phyloseq(
  otu_table(seqtab.nochim, taxa_are_rows = FALSE),
  sample_data(samp),
  tax_table(taxa)
)
dna <- Biostrings::DNAStringSet(taxa_names(ps))
names(dna) <- taxa_names(ps)
ps <- merge_phyloseq(ps, dna)
taxa_names(ps) <- paste0("ASV", seq(ntaxa(ps)))
ps
View(otu_table(ps))

saveRDS(ps, file = "01_RowData/ps_helmints")
class(ps)

library(dada2)
library(phyloseq)

path <- "../../fastq_files2"

fnFs <- sort(list.files(path, pattern="_1.fastq", full.names = TRUE))
fnRs <- sort(list.files(path, pattern="_2.fastq", full.names = TRUE))

sample.names <- sapply(strsplit(basename(fnFs), "_"), `[`, 1)
sample.names

filtFs <- file.path(path, "filtered", paste0(sample.names, "_F_filt.fastq.gz"))
filtRs <- file.path(path, "filtered", paste0(sample.names, "_R_filt.fastq.gz"))
names(filtFs) <- sample.names
names(filtRs) <- sample.names

out <- filterAndTrim(fnFs, filtFs, fnRs, filtRs, truncLen=c(240,160),
                     maxN=0, maxEE=c(2,2), truncQ=2, rm.phix=TRUE,
                     compress=TRUE) 
errF <- learnErrors(filtFs)

errR <- learnErrors(filtRs)

dadaFs <- dada(filtFs, err=errF)
dadaRs <- dada(filtRs, err=errR)


mergers <- mergePairs(dadaFs, filtFs, dadaRs, filtRs, verbose=TRUE)
seqtab <- makeSequenceTable(mergers)
seqtab.nochim <- removeBimeraDenovo(seqtab, method="consensus", verbose=TRUE)
rownames(seqtab.nochim) <- sample.names
sum(seqtab.nochim)/sum(seqtab)

getN <- function(x) sum(getUniques(x))
track <- cbind(out, sapply(dadaFs, getN), sapply(dadaRs, getN), sapply(mergers, getN), rowSums(seqtab.nochim))
colnames(track) <- c("input", "filtered", "denoisedF", "denoisedR", "merged", "nonchim")
rownames(track) <- sample.names
head(track)
taxa <- assignTaxonomy(seqtab.nochim, "../Genomica_Funcional_MARF_2025-1/Dada2/Ejercicio_1/01_Raw_Data/silva_nr99_v138.2_toGenus_trainset (1).fa.gz")
taxa.print <- taxa
rownames(taxa.print) <- NULL
head(taxa.print)

library(phyloseq)
library(Biostrings)
library(ggplot2)
theme_set(theme_bw())

sample_metadata <- read.csv("../../SraRunTable2.csv", row.names=1)
samp <- sample_data(sample_metadata)

ps <- phyloseq(
  otu_table(seqtab.nochim, taxa_are_rows = FALSE),
  sample_data(samp),
  tax_table(taxa)
)
dna <- Biostrings::DNAStringSet(taxa_names(ps))
names(dna) <- taxa_names(ps)
ps <- merge_phyloseq(ps, dna)
taxa_names(ps) <- paste0("ASV", seq(ntaxa(ps)))
ps
View(otu_table(ps))

saveRDS(ps, file = "01_RowData/ps_helmints2")
class(ps)

path <- "../../fastq_files3"

fnFs <- sort(list.files(path, pattern="_1.fastq", full.names = TRUE))
fnRs <- sort(list.files(path, pattern="_2.fastq", full.names = TRUE))

sample.names <- sapply(strsplit(basename(fnFs), "_"), `[`, 1)
sample.names

filtFs <- file.path(path, "filtered", paste0(sample.names, "_F_filt.fastq.gz"))
filtRs <- file.path(path, "filtered", paste0(sample.names, "_R_filt.fastq.gz"))
names(filtFs) <- sample.names
names(filtRs) <- sample.names

out <- filterAndTrim(fnFs, filtFs, fnRs, filtRs, truncLen=c(240,160),
                     maxN=0, maxEE=c(2,2), truncQ=2, rm.phix=TRUE,
                     compress=TRUE) 
errF <- learnErrors(filtFs)

errR <- learnErrors(filtRs)

dadaFs <- dada(filtFs, err=errF)
dadaRs <- dada(filtRs, err=errR)


mergers <- mergePairs(dadaFs, filtFs, dadaRs, filtRs, verbose=TRUE)
seqtab <- makeSequenceTable(mergers)
seqtab.nochim <- removeBimeraDenovo(seqtab, method="consensus", verbose=TRUE)
rownames(seqtab.nochim) <- sample.names
sum(seqtab.nochim)/sum(seqtab)

getN <- function(x) sum(getUniques(x))
track <- cbind(out, sapply(dadaFs, getN), sapply(dadaRs, getN), sapply(mergers, getN), rowSums(seqtab.nochim))
colnames(track) <- c("input", "filtered", "denoisedF", "denoisedR", "merged", "nonchim")
rownames(track) <- sample.names
head(track)
taxa <- assignTaxonomy(seqtab.nochim, "../Genomica_Funcional_MARF_2025-1/Dada2/Ejercicio_1/01_Raw_Data/silva_nr99_v138.2_toGenus_trainset (1).fa.gz")
taxa.print <- taxa
rownames(taxa.print) <- NULL
head(taxa.print)

library(phyloseq)
library(Biostrings)
library(ggplot2)
theme_set(theme_bw())

sample_metadata <- read.csv("../../SraRunTable3.csv", row.names=1)
samp <- sample_data(sample_metadata)

ps <- phyloseq(
  otu_table(seqtab.nochim, taxa_are_rows = FALSE),
  sample_data(samp),
  tax_table(taxa)
)
dna <- Biostrings::DNAStringSet(taxa_names(ps))
names(dna) <- taxa_names(ps)
ps <- merge_phyloseq(ps, dna)
taxa_names(ps) <- paste0("ASV", seq(ntaxa(ps)))
ps
View(otu_table(ps))

saveRDS(ps, file = "01_RowData/ps_plasmodium")
class(ps)

path <- "../../fastq_files4"

fnFs <- sort(list.files(path, pattern="_1.fastq", full.names = TRUE))
fnRs <- sort(list.files(path, pattern="_2.fastq", full.names = TRUE))

sample.names <- sapply(strsplit(basename(fnFs), "_"), `[`, 1)
sample.names

filtFs <- file.path(path, "filtered", paste0(sample.names, "_F_filt.fastq.gz"))
filtRs <- file.path(path, "filtered", paste0(sample.names, "_R_filt.fastq.gz"))
names(filtFs) <- sample.names
names(filtRs) <- sample.names

out <- filterAndTrim(fnFs, filtFs, fnRs, filtRs, truncLen=c(240,160),
                     maxN=0, maxEE=c(2,2), truncQ=2, rm.phix=TRUE,
                     compress=TRUE) 
errF <- learnErrors(filtFs)

errR <- learnErrors(filtRs)

dadaFs <- dada(filtFs, err=errF)
dadaRs <- dada(filtRs, err=errR)


mergers <- mergePairs(dadaFs, filtFs, dadaRs, filtRs, verbose=TRUE)
seqtab <- makeSequenceTable(mergers)
seqtab.nochim <- removeBimeraDenovo(seqtab, method="consensus", verbose=TRUE)
rownames(seqtab.nochim) <- sample.names
sum(seqtab.nochim)/sum(seqtab)

getN <- function(x) sum(getUniques(x))
track <- cbind(out, sapply(dadaFs, getN), sapply(dadaRs, getN), sapply(mergers, getN), rowSums(seqtab.nochim))
colnames(track) <- c("input", "filtered", "denoisedF", "denoisedR", "merged", "nonchim")
rownames(track) <- sample.names
head(track)
taxa <- assignTaxonomy(seqtab.nochim, "../Genomica_Funcional_MARF_2025-1/Dada2/Ejercicio_1/01_Raw_Data/silva_nr99_v138.2_toGenus_trainset (1).fa.gz")
taxa.print <- taxa
rownames(taxa.print) <- NULL
head(taxa.print)

library(phyloseq)
library(Biostrings)
library(ggplot2)
theme_set(theme_bw())

sample_metadata <- read.csv("../../SraRunTable4.csv", row.names=1)
samp <- sample_data(sample_metadata)

ps <- phyloseq(
  otu_table(seqtab.nochim, taxa_are_rows = FALSE),
  sample_data(samp),
  tax_table(taxa)
)
dna <- Biostrings::DNAStringSet(taxa_names(ps))
names(dna) <- taxa_names(ps)
ps <- merge_phyloseq(ps, dna)
taxa_names(ps) <- paste0("ASV", seq(ntaxa(ps)))
return(ps)

View(otu_table(ps))

saveRDS(ps, file = "01_RowData/ps_helmints")
class(ps)



path <- "../../fastq_files5"
fnFs <- sort(list.files(path, pattern="_1.fastq", full.names = TRUE))

sample.names <- sapply(strsplit(basename(fnFs), "_"), `[`, 1)

filtFs <- file.path(path, "filtered", paste0(sample.names, "_F_filt.fastq.gz"))
names(filtFs) <- sample.names

out <- filterAndTrim(fnFs, filtFs, truncLen=240,
                     maxN=0, maxEE=2, truncQ=2, rm.phix=TRUE,
                     compress=TRUE, multithread=TRUE)

errF <- learnErrors(filtFs, multithread=TRUE)

dadaFs <- dada(filtFs, err=errF, multithread=TRUE)

seqtab <- makeSequenceTable(dadaFs)

seqtab.nochim <- removeBimeraDenovo(seqtab, method="consensus", verbose=TRUE)

getN <- function(x) sum(getUniques(x))
track <- cbind(out, sapply(dadaFs, getN), rowSums(seqtab.nochim))
colnames(track) <- c("input", "filtered", "denoised", "nonchim")
rownames(track) <- sample.names
head(track)

taxa <- assignTaxonomy(seqtab.nochim, "../Genomica_Funcional_MARF_2025-1/Dada2/Ejercicio_1/01_Raw_Data/silva_nr99_v138.2_toGenus_trainset (1).fa.gz")

sample_metadata <- read.csv("../../SraRunTable5.csv", row.names=1)
samp <- sample_data(sample_metadata)

ps <- phyloseq(
  otu_table(seqtab.nochim, taxa_are_rows = FALSE),
  sample_data(samp),
  tax_table(taxa)
)

dna <- DNAStringSet(taxa_names(ps))
names(dna) <- taxa_names(ps)
ps <- merge_phyloseq(ps, dna)
taxa_names(ps) <- paste0("ASV", seq(ntaxa(ps)))
