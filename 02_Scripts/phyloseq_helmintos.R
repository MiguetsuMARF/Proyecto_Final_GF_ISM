library(dada2)
library(phyloseq)

path <- "../../fastq_files"
fnFs <- sort(list.files(path, pattern="_1.fastq$", full.names = TRUE))
fnRs <- sort(list.files(path, pattern="_2.fastq$", full.names = TRUE))

sample.names <- sapply(strsplit(basename(fnFs), "_"), `[`, 1)

filtFs <- file.path(path, "filtered", paste0(sample.names, "_F_filt.fastq.gz"))
filtRs <- file.path(path, "filtered", paste0(sample.names, "_R_filt.fastq.gz"))
names(filtFs) <- sample.names
names(filtRs) <- sample.names
out <- filterAndTrim(fnFs, filtFs, fnRs, filtRs, truncLen=c(240,160),
                     maxN=0, maxEE=c(2,2), truncQ=2, compress=TRUE, multithread=TRUE)

errF <- learnErrors(filtFs, multithread=TRUE)
errR <- learnErrors(filtRs, multithread=TRUE)

derepFs <- derepFastq(filtFs)
derepRs <- derepFastq(filtRs)
dadaFs <- dada(derepFs, err=errF, multithread=TRUE)
dadaRs <- dada(derepRs, err=errR, multithread=TRUE)

mergers <- mergePairs(dadaFs, derepFs, dadaRs, derepRs)
seqtab <- makeSequenceTable(mergers)
seqtab.nochim <- removeBimeraDenovo(seqtab, method="consensus", multithread=TRUE)

taxa <- assignTaxonomy(seqtab.nochim, "../Genomica_Funcional_MARF_2025-1/Dada2/Ejercicio_1/01_Raw_Data/silva_nr99_v138.2_toGenus_trainset (1).fa.gz", multithread=TRUE)
taxa
library(phyloseq)

otu <- otu_table(seqtab.nochim, taxa_are_rows=FALSE)
tax <- tax_table(taxa)

sample_metadata <- read.csv("../../SraRunTable.csv", row.names=1)
samp <- sample_data(sample_metadata)

ps <- phyloseq(otu, tax, samp) 
ps

saveRDS(ps, file = "01_RowData/ps_helmints")


path <- "../../fastq_files2"
fnFs <- sort(list.files(path, pattern="_1.fastq$", full.names = TRUE))
fnRs <- sort(list.files(path, pattern="_2.fastq$", full.names = TRUE))

sample.names <- sapply(strsplit(basename(fnFs), "_"), `[`, 1)

filtFs <- file.path(path, "filtered", paste0(sample.names, "_F_filt.fastq.gz"))
filtRs <- file.path(path, "filtered", paste0(sample.names, "_R_filt.fastq.gz"))
names(filtFs) <- sample.names
names(filtRs) <- sample.names
out <- filterAndTrim(fnFs, filtFs, fnRs, filtRs, truncLen=c(240,160),
                     maxN=0, maxEE=c(2,2), truncQ=2, compress=TRUE, multithread=TRUE)

errF <- learnErrors(filtFs, multithread=TRUE)
errR <- learnErrors(filtRs, multithread=TRUE)

derepFs <- derepFastq(filtFs)
derepRs <- derepFastq(filtRs)
dadaFs <- dada(derepFs, err=errF, multithread=TRUE)
dadaRs <- dada(derepRs, err=errR, multithread=TRUE)

mergers <- mergePairs(dadaFs, derepFs, dadaRs, derepRs)
seqtab <- makeSequenceTable(mergers)
seqtab.nochim <- removeBimeraDenovo(seqtab, method="consensus", multithread=TRUE)

taxa <- assignTaxonomy(seqtab.nochim, "../Genomica_Funcional_MARF_2025-1/Dada2/Ejercicio_1/01_Raw_Data/silva_nr99_v138.2_toGenus_trainset (1).fa.gz", multithread=TRUE)
taxa
library(phyloseq)

otu <- otu_table(seqtab.nochim, taxa_are_rows=FALSE)
tax <- tax_table(taxa)

sample_metadata <- read.csv("../../SraRunTable2.csv", row.names=1)
samp <- sample_data(sample_metadata)

ps <- phyloseq(otu, tax, samp) 
ps

saveRDS(ps, file = "01_RowData/RDS_ps/ps_helmints2")