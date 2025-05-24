
### Script para metadatos de todas las bases de datos ###

Datos_parasitos <- data.frame(
  Parasito = c("Ascaris", "Opisthorchis", "Trichuris",
               "Ancilostoma", "Necator", "Taenia Saginata",
               "Haplorchis taichui"), ## Aqui se agregan los parasitos que vamos a utilizar
  
  Mecanismo_patogenicidad = c(1:7),
  
  Tipo_de_parasito = c("nematodo", "trematodo", "nematodo",
                       "nematodo", "nematodo", "cestodo",
                       "trematodo"),
  
  Intra_o_extra_cel = c("extracelular", "extracelular", "extracelular",
                        "extracelular", "extracelular", "extracelular",
                        "extracelular"),
  
  Localizacion_anatomica = c("intestino_delgado", "conductos_biliares", "ciego/colon",
                             "intestino_delgado", "intestino_delgado", "intestino_delgado",
                             "intestino_delgado"),
  
  Directo_Indirecto = c("directo", "indirecto", "directo",
                        "directo", "directo","indirecto",
                        "indirecto"),
  
  Transmision = c("fecal/oral", "alimentos", "fecal/oral",
                  "penetracion_cutanea", "penetracion_cutanea", "fecal/oral/alimentos",
                  "alimentos"),

  
  Zoonosis = c("si", "si", "no",
               "no", "no", "si",
               "si"),
  
  Distribucion = c("mundial", "europa/asia", "zonas_tropicales",
                   "mundial", "zonas_tropicales", "mundial",
                   "asia")
  
  
)

View(Datos_parasitos)




