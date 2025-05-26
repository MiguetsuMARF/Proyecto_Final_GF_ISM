
## ----------------------------------- CREANDO PHYLOSEQS -------------------------------------------- ##}

# Para empezar a trabajar con los archivos de secuenciacion necesitamos una carpeta previa con los 
# fastq ya extraidos. Esto se realizo en bash con los siguientes comandos:

## > mkdir fastq_files raw_sra
## > prefetch --option-file SraAccList.csv --output-directory raw_sra
## > cd raw_sra
## > for srr in $(cat ../SraAccList.csv); do   fasterq-dump $srr -O ../fastq_files --split-files --threads 4; done

# De esta forma tendremos una carpeta de nombre fastq_files que contiene los archivos fastq.
# En este Rproyect no se incluyen los archivos fastq debido a las limitaciones de github de espacio por repositorio.

library(dada2)
library(phyloseq)

# primero especificamos la ruta de origen de los fastq.
path <- "../../fastq_files"

# importamos los nombres de acceso
fnFs <- sort(list.files(path, pattern="_1.fastq", full.names = TRUE))
fnRs <- sort(list.files(path, pattern="_2.fastq", full.names = TRUE))

sample.names <- sapply(strsplit(basename(fnFs), "_"), `[`, 1)
sample.names

# creamos los nuevos archivos que contendran los fastq filtrados.
filtFs <- file.path(path, "filtered", paste0(sample.names, "_F_filt.fastq.gz"))
filtRs <- file.path(path, "filtered", paste0(sample.names, "_R_filt.fastq.gz"))
names(filtFs) <- sample.names
names(filtRs) <- sample.names

# eliminamos aquellos fragmentos con baja calidad phred, la calidad se reviso con fastqc en bash.

out <- filterAndTrim(fnFs, filtFs, fnRs, filtRs, truncLen=c(240,160),
                     maxN=0, maxEE=c(2,2), truncQ=2, rm.phix=TRUE,
                     compress=TRUE) 

# posteriormente se usa la funcion learnErrors para analizar la secuencia y su calidad.
errF <- learnErrors(filtFs)

errR <- learnErrors(filtRs)

dadaFs <- dada(filtFs, err=errF)
dadaRs <- dada(filtRs, err=errR)

# unimos los fragmentos L y R.
mergers <- mergePairs(dadaFs, filtFs, dadaRs, filtRs, verbose=TRUE)
seqtab <- makeSequenceTable(mergers)

# Eliminamos quimeras.
seqtab.nochim <- removeBimeraDenovo(seqtab, method="consensus", verbose=TRUE)
rownames(seqtab.nochim) <- sample.names
sum(seqtab.nochim)/sum(seqtab)


# posteriormente seguimos trabajando con los archivos.
getN <- function(x) sum(getUniques(x))
track <- cbind(out, sapply(dadaFs, getN), sapply(dadaRs, getN), sapply(mergers, getN), rowSums(seqtab.nochim))
colnames(track) <- c("input", "filtered", "denoisedF", "denoisedR", "merged", "nonchim")
rownames(track) <- sample.names
head(track)

# Asignamos taxonomia, para esto se necesita el archivo trainset silva para comparar la secuencia de cada ASV detectado con la base de datos.
taxa <- assignTaxonomy(seqtab.nochim, "../Genomica_Funcional_MARF_2025-1/Dada2/Ejercicio_1/01_Raw_Data/silva_nr99_v138.2_toGenus_trainset (1).fa.gz")
taxa.print <- taxa
rownames(taxa.print) <- NULL
head(taxa.print)

library(phyloseq)
library(Biostrings)

# Asignamos los metadatos del proyecto en especifico.
sample_metadata <- read.csv("../../SraRunTable.csv", row.names=1)
samp <- sample_data(sample_metadata)

# Ahora si podemos generar el objeto phyloseq.
ps <- phyloseq(
  otu_table(seqtab.nochim, taxa_are_rows = FALSE),
  sample_data(samp),
  tax_table(taxa)
)

# y finalmente asignamos los nombres ASV al otu_table dependiendo de la secuencia con ayuda de biostrings.
dna <- Biostrings::DNAStringSet(taxa_names(ps))
names(dna) <- taxa_names(ps)
ps <- merge_phyloseq(ps, dna)
taxa_names(ps) <- paste0("ASV", seq(ntaxa(ps)))
ps
View(otu_table(ps))

# Debido a que se trabajo de forma externa al proyecto se exporta como archivo RDS.
saveRDS(ps, file = "01_RowData/ps_helmints")



# Repetimos el mismo proceso para cada phyloseq.

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

View(seqtab)

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

saveRDS(ps, file = "01_RowData/ps_schisto")
class(ps)

ps

any(otu_table(ps) != 0)


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
