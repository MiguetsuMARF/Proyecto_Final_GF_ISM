                      # Phyloseq de parasitos #

# No tenia microbiomeMarker asi que lo instale #
BiocManager::install("microbiomeMarker")

# Tampoco tenía este
BiocManager::install("SIAMCAT")


# Loading libraries:
suppressMessages({
  library(ggplot2)
  library(IRdisplay)    
  library(MGnifyR)
  library(microbiomeMarker)
  library(plyr)
  library(SIAMCAT)
  library(tidyverse)
  library(vegan)
})


# Setting tables and figures size to display (these will be reset later):
options(repr.matrix.max.cols=150, repr.matrix.max.rows=200)
options(repr.plot.width=4, repr.plot.height=4)


# Create your session mgnify_client object
mg = mgnify_client(usecache = T, cache_dir = '/home/jovyan/.mgnify_cache')
tara_all = mgnify_analyses_from_studies(mg, 'MGYS00002008')


          # 1.1
# Create your session mgnify_client object
mg = mgnify_client(usecache = T, cache_dir = '/home/jovyan/.mgnify_cache')
tara_all = mgnify_analyses_from_studies(mg, 'MGYS00002008')


metadata = mgnify_get_analyses_metadata(mg, tara_all)

      # 1.2
length(metadata$'analysis_accession')

unique(metadata$'analysis_experiment-type')

v5_metadata = metadata[which(metadata$'analysis_pipeline-version'=='5.0'), ]

table(v5_metadata$'sample_environment-feature')

# Saving the list of Surface water samples in a dataframe
sub1 = v5_metadata[str_detect(v5_metadata$'sample_environment-feature', "surface"), ]

# Reducing the metadata table to keep relevant fields only
variables_to_keep = c('sample_temperature','sample_depth','sample_salinity','sample_chlorophyll sensor','sample_nitrate sensor','sample_oxygen sensor')
reduced_sub1 = sub1[variables_to_keep]

# Removing rows with extreme values
reduced_sub1[reduced_sub1 == "99999"] <- NA
reduced_sub1[reduced_sub1 == "99999.0"] <- NA
reduced_sub1[reduced_sub1 == "0"] <- NA

clean1=na.omit(reduced_sub1)

# Subsampling to 34
set.seed(345)
random_1 = clean1[sample(nrow(clean1), 34), ]
random_1$'env_label'=c(rep('Surface', times=length(rownames(random_1))))



# Saving the list of Mesopelagic zone samples in a dataframe
sub2 = v5_metadata[str_detect(v5_metadata$'sample_environment-feature', "mesopelagic"), ]

# Reducing the metadata table to keep relevant fields only
reduced_sub2 = sub2[variables_to_keep]

# Removing rows with extreme values
reduced_sub2[reduced_sub2 == "99999"] <- NA
reduced_sub2[reduced_sub2 == "99999.0"] <- NA
reduced_sub2[reduced_sub2 == "0"] <- NA

clean2=na.omit(reduced_sub2)

# Subsampling to 34
set.seed(345)
random_2 = clean2[sample(nrow(clean2), 34), ]
random_2$'env_label'=c(rep('Mesopelagic', times=length(rownames(random_2))))


clean_metadata=rbind(random_1,random_2)
clean_acc=rownames(clean_metadata)


      # 1.3 COVERTIR A PHYLOSEQ
ps = mgnify_get_analyses_phyloseq(mg, clean_acc)

# Keeping relevant metadata in the phyloseq object
variables_to_keep = c('sample_temperature','sample_depth','sample_salinity','sample_chlorophyll.sensor','sample_nitrate.sensor','sample_oxygen.sensor')
df = data.frame(sample_data(ps))[variables_to_keep]

# Transforming character to nummeric variables
df[] = lapply(df, function(x) as.numeric(as.character(x)))
sample_data(ps) = df

# Adding the env label                              
sample_data(ps)$'env_label' = clean_metadata$env_label


        # aqui seguiria PART 2. NORMALIZATION ETC.