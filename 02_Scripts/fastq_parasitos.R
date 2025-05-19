               # Descargando los fastq de los parasitos en bash #

library(readr)
library(httr)
library(jsonlite)
library(dplyr)

# Leer el CSV
data <- tabla_links

# Extraer los IDs de los runs (SRR...) desde la columna 'run'
data <- data %>%
  mutate(run_accession = gsub(".*/(SRR\\d+).*", "\\1", run))

# vere si uedo hacer esta mierda en bash
data$run_accession -> codigos_acceso

writeLines(codigos_acceso, "codigos.txt")
  
# prefetch SRR8356197 --output-directory parasitos --progress
# cd parasitos
# fasterq-dump SRR8356197 --split-files --include-technical --progress
# FUNCIONO!!!

# prefetch SRR8356198 --output-directory parasitos --progress
# cd parasitos
# fasterq-dump SRR8356198 --split-files --include-technical --progress


# script de bash -----

# se llama descargar_fastq.sh

#!/bin/bash

# Directorio donde guardar los archivos
# OUTDIR="parasitos"
# mkdir -p "$OUTDIR"

# Archivo con los códigos
# CODIGOS="codigos.txt"

# Descargar y convertir cada archivo
# while read -r ACC; do
# echo "Descargando $ACC..."
# prefetch "$ACC" --output-directory "$OUTDIR" --progress

# echo "Convirtiendo $ACC a fastq..."
# fasterq-dump "$OUTDIR/$ACC" --split-files --include-technical --progress -O "$OUTDIR"
# done < "$CODIGOS"

# echo "Todos los archivos han sido procesados."


# ejecutar el script ---
# chmod +x descargar_fastq.sh
# ./descargar_fastq.sh

