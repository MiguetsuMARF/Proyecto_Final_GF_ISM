
### Script para metadatos de todas las bases de datos ###

Datos_parasitos <- data.frame(
  Parasito = c("Ascaris", "Opisthorchis", "Trichuris",
               "Ancilostoma", "Necator", "Taenia_Saginata",
               "Haplorchis_taichui", "Schistosoma_mansoni"), ## Aqui se agregan los parasitos que vamos a utilizar
  
  Mecanismo_patogenicidad = c(1:6,"ventosa_oral/ventral" , "tegumento"),
  
  Tipo_de_parasito = c("nematodo", "trematodo", "nematodo",
                       "nematodo", "nematodo", "cestodo",
                       "trematodo", "trematodo"),
  
  Intra_o_extra_cel = c("extracelular", "extracelular", "extracelular",
                        "extracelular", "extracelular", "extracelular",
                        "extracelular", "extracelular"),
  
  Localizacion_anatomica = c("intestino_delgado", "conductos_biliares", "ciego/colon",
                             "intestino_delgado", "intestino_delgado", "intestino_delgado",
                             "intestino_delgado", "venas_mesentericas"),
  
  Directo_Indirecto = c("directo", "indirecto", "directo",
                        "directo", "directo","indirecto",
                        "indirecto", "indirecto"),
  
  Transmision = c("fecal/oral", "alimentos", "fecal/oral",
                  "penetracion_cutanea", "penetracion_cutanea", "fecal/oral/alimentos",
                  "alimentos", "agua_contaminada"),

  
  Zoonosis = c("si", "si", "no",
               "no", "no", "si",
               "si", "no"),
  
  Distribucion = c("mundial", "europa/asia", "zonas_tropicales",
                   "mundial", "zonas_tropicales", "mundial",
                   "asia", "america/africa")
  
  
)

View(Datos_parasitos)




