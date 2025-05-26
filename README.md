# Proyecto_Final_GF_ISM

Proyecto en R para el proyecto final de Genomica Funcional

## Objetivo

Generar redes a partir de caracteristicas descriptivas de parasitos y analizar como varia la arquitectura de estas. 
### Datos utilizados
- Datos biologicos que describen su infeccion.
- Datos de secuenciacion de microbioma (16s) posterior a la infeccion.
- Diversidad de ASV por parasito
- Abundancia de ASV por parasito

## Estructura

### 01Data 
- Carpeta de RDS
  Contiene los archivos phyloseqs en formato RDS que se utilizaron para el analisis.
- Carpeta de fastq
- Archivos sueltos de metadatos y srr para generar phyloseqs.

### 02Scripts
- Redes_caracteristicas
Script para generar red a partir de datos de caracteristicas biologicas de cara parasito analizado.
- Script_base_datos
Script donde se genero la base de datos y la base de datos binaria con las caracteristicas biologicas necesarias para construir red.
- uniendo_phyloseqs
Script donde se utilizaron las versiones filtradas de cada phyloseq y se genero una base de datos con las abundancias promedio de cada parasito para la construccion de la red.
- Script_crear_phyloseqs
Script utilizado para generar los objetos phyloseq, ademas contiene en formato de comentario el codigo en bash que se utilizo para obtener los archivos fastq.
- Redes_abundancias
Script que contiene el codigo que se utilizo para generar redes a partir de los datos de abundancia generados en el script "uniendo_phyloseq"
- Script_editando_metadatos
Script donde se agregaron a los metadatos de cada phyloseq las columnas especificas que describen que parasito esta infectando, ademas se filtraron los phyloseq con multiples infecciones para generar nuevos phyloseq individuales.
- Script_phyloseqs_RDS
Script que contiene los codigos para obtener los phyloseq finales utilizados para los analisis, estos ya estan filtrados y tienen las columnas correspondientes en metadatos.
- Funcion_diversidades
Script para calcular y generar una base de datos con los calculos de diversidades para cada phyloseq, ademas de a partir de estos datos generar redes y estudiar su estructura.
- Script_ascaris_ancylostoma
Script que se utilizo para descargar y generar los datos phyloseq de ascaris y ancylostoma.
- Fastq_parasitos
Script que se utilizo para descargar y generar los datos phyloseq del control.

### 03Results
Contiene en formato pdf y png las redes ya clusterizadas de cada tipo de analisis realizado.

### Formato de ia

Formatos de ia de todos los integrantes.


## Bibliografia para generar los objetos phyloseq

Para el control: Easton, A. V., Quiñones, M., Vujkovic-Cvijin, I., Oliveira, R. G., Kepha, S., Odiere, M. R., Anderson, R. M., Belkaid, Y., & Nutman, T. B. (2019). The impact of anthelmintic treatment on human gut Microbiota based on cross-sectional and pre- and postdeworming comparisons in western Kenya. mBio, 10(2). <https://doi.org/10.1128/mBio.00519-19>

Para Ancilostoma 2: Appiah-Twum, F., Akorli, J., Okyere, L., Sagoe, K., Osabutey, D., Cappello, M., & Wilson, M. D. (2023). The effect of single dose albendazole (400 mg) treatment on the human gut microbiome of hookworm-infected Ghanaian individuals. Scientific Reports, 13(1), 11302. <https://doi.org/10.1038/s41598-023-38376-3>

Para diversos helmintos: Gobert, G. N., Atkinson, L. E., Lokko, A., Yoonuan, T., Phuphisut, O., Poodeepiyasawat, A., ... & Adisakwattana, P. (2022). Clinical helminth infections alter host gut and saliva microbiota. PLoS Neglected Tropical Diseases, 16(6), e0010491.

Para Haplorchis: Prommi, A., Prombutara, P., Watthanakulpanich, D., Adisakwattana, P., Kusolsuk, T., Yoonuan, T., ... & Chaisiri, K. (2020). Intestinal parasites in rural communities in Nan Province, Thailand: changes in bacterial gut microbiota associated with minute intestinal fluke infection. Parasitology, 147(9), 972-984.
