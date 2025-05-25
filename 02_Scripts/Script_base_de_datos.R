
### Script para metadatos de todas las bases de datos ###

Datos_parasitos <- data.frame(
  Parasito = c("Ascaris", "Opisthorchis", "Trichuris",
               "Ancilostoma", "Necator", "Taenia_Saginata",
               "Haplorchis_taichui", "Schistosoma_mansoni", "Plasmodium"), ## Aqui se agregan los parasitos que vamos a utilizar
  
  Mecanismo_patogenicidad = c("cuticula/labios/enzimas", "ventosas/espinas", "extremo_anterior",
                              "dientes/enzimas", "cuticula/enzimas", "ventosas",
                              "ventosas" , "tegumento", "micronemas/proteinas_adhesion/antigenos_superficie/gametocitos"),
  # me gustaria reducir todos los tipos de enzimas a solo enzimas, y ventosas a solo ventosas.
  
  Tipo_de_parasito = c("nematodo", "trematodo", "nematodo",
                       "nematodo", "nematodo", "cestodo",
                       "trematodo", "trematodo", "apicomplexo"),
  
  Intra_o_extra_cel = c("extracelular", "extracelular", "extracelular",
                        "extracelular", "extracelular", "extracelular",
                        "extracelular", "extracelular", "intracelular"),
  
  Localizacion_anatomica = c("intestino_delgado", "conductos_biliares", "ciego/colon",
                             "intestino_delgado", "intestino_delgado", "intestino_delgado",
                             "intestino_delgado", "venas_mesentericas", "hepatocitos/eritrocitos"),
  
  Directo_Indirecto = c("directo", "indirecto", "directo",
                        "directo", "directo","indirecto",
                        "indirecto", "indirecto", "indirecto"),
  
  Transmision = c("fecal/oral", "alimentos", "fecal/oral",
                  "penetracion_cutanea", "penetracion_cutanea", "fecal/oral/alimentos",
                  "alimentos", "agua_contaminada", "mosquitos"),

  
  Zoonosis = c("si", "si", "no",
               "no", "no", "si",
               "si", "no", "si"),
  
  Distribucion = c("mundial", "europa/asia", "zonas_tropicales",
                   "mundial", "zonas_tropicales", "mundial",
                   "asia", "america/africa", "zonas_tropicales")
  
  
)

View(Datos_parasitos)

<<<<<<< HEAD

caracteristicas_parasitos <- data.frame(
  Parasito = c("Ascaris", "Opisthorchis", "Trichuris",
               "Ancilostoma", "Necator", "Taenia_Saginata",
               "Haplorchis_taichui", "Schistosoma_mansoni", "Plasmodium"), 
  
  cuticula = c(1,0,0,0,1,0,0,0,0),
  
  labios   = c(1,0,0,0,0,0,0,0,0),
  
  enzimas  = c(1,0,0,1,1,0,0,0,0),
  
  ventosas = c(0,1,0,0,0,1,1,0,0),
  
  espinas  = c(0,1,0,0,0,0,0,0,0),
  
  extremo_anterior = c(0,0,1,0,0,0,0,0,0),
  
  dientes  = c(0,0,0,1,0,0,0,0,0),
  
  tegumento = c(0,0,0,0,0,0,0,1,0),
  
  micronemas = c(0,0,0,0,0,0,0,0,1), 
  
  proteinas_adhesion = c(0,0,0,0,0,0,0,0,1),
  
  antigenos_superficie = c(0,0,0,0,0,0,0,0,1),
  
  gametocitos = c(0,0,0,0,0,0,0,0,1),
  
  nematodo  = c(1,0,1,1,1,0,0,0,0),
  
  trematodo = c(0,1,0,0,0,0,1,1,0),
  
  apicomplexo = c(0,0,0,0,0,0,0,0,1),
  
  intracelular = c(0,0,0,0,0,0,0,0,1),
  
  extracelular = c(1,1,1,1,1,1,1,1,0),
  
  intestino_delgado = c(1,0,0,1,1,1,1,0,0),
  
  conductos_biliares = c(0,1,0,0,0,0,0,0,0),
  
  ciego = c(0,0,1,0,0,0,0,0,0),
  
  colon = c(0,0,1,0,0,0,0,0,0),
  
  venas_mesentericas = c(0,0,0,0,0,0,0,1,0),
  
  hepatocitos = c(0,0,0,0,0,0,0,0,1), 
  
  eritrocitos = c(0,0,0,0,0,0,0,0,1),
  
  ciclo_directo = c(1,0,1,1,1,0,0,0,0),
  
  transmision_fecal_oral = c(1,0,1,0,0,1,0,0,0),
  
  transmision_alimentos =  c(0,1,0,0,0,1,1,0,0),
  
  transmision_penetracion_cutanea = c(0,0,0,1,1,0,0,0,0),
  
  transmision_agua_contaminada = c(0,0,0,0,0,0,0,1,0),
  
  transmision_mosquitos = c(0,0,0,0,0,0,0,0,1),
  
  zoonosis = c(1,1,0,0,0,1,1,0,1),
  
  distribucion_mundial = c(1,0,0,1,0,1,0,0,0),
  
  distribucion_europa =  c(1,1,0,1,0,1,0,0,0),
  
  distribucion_asia   =  c(1,1,0,1,0,1,1,0,0),
  
  distribucion_tropical = c(1,0,1,1,1,1,0,1,1)
  
  
  # no inclui affrica y america porque el vector queda igual al de distribucion tropical
=======
Datos_parasitos2 <- data.frame(
  Parasito = c("Ascaris", "Opisthorchis", "Trichuris",
               "Ancilostoma", "Necator", "Taenia_Saginata",
               "Haplorchis_taichui", "Schistosoma_mansoni"),
  Cuticula = c(1,0,0,0,1,0,0,0),
  Labios = c(1,0,0,0,0,0,0,0)
>>>>>>> e0b134d69b99a325cbff44421c38f6ffc0482787
)

View(caracteristicas_parasitos)
