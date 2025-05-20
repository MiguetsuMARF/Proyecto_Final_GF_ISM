library(glue)

get_variable_from_link_or_input <- function(variable, name = 'accession', default = NA) {
  var <- Sys.getenv(variable, unset = NA)
  if (!is.na(var)) {
    print(glue('Using {name} = {var} from the link you followed.'))
  } else {
    determiner <- ifelse(grepl(tolower(substr(name, 0, 1)), 'aeiou'), 'an', 'a')
    var <- readline(prompt = glue("Type {determiner} {name} [default: {default}]"))
  }
  var <- ifelse(is.na(var) || var == '', default, var)
  print(glue('Using "{var}" as {name}'))
  var
}
mgnify_study_accession <- get_variable_from_link_or_input('MGYS', 'Study Accession', 'MGYS00005116')
library(vegan)
library(ggplot2)
library(phyloseq)

library(MGnifyR)

mg <- MgnifyClient(usecache = T, cache_dir = '/home/jovyan/.mgnify_cache')
library(IRdisplay)

analyses_accessions <- searchAnalysis(mg, "studies", mgnify_study_accession)
analyses_accessions
analyses_metadata_df <- getMetadata(mg, head(analyses_accessions, 10));
t(head(analyses_metadata_df))
analyses_ps <- getResult(mg, analyses_metadata_df$analysis_accession, tax_SU = "SSU")
analyses_ps
