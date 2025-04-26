#=================Chargement des librairies=================#
library(tidyverse) # librarie pour les pipes et autres qualité de vie
library(stringr)   # pour les RE

# this setwd() only works for Rstudio.
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


#=================Chargement des données=================#

CatAusGPS = read.csv("../data/PetCatsAustraliaGPS"
                     , stringsAsFactors = F)
CatAusCarac = read.csv("../data/PetCatsAustraliaCaract"
                       , stringsAsFactors = F)



#=================Définition des facteurs=================#

#-----------------Depuis les caracteristiques des chats-----------------#
Caracs = c( "animal.id","deploy.on.date","deploy.off.date","animal.comments",
            "animal.life.stage",  "animal.reproductive.condition","animal.sex",
            "manipulation.comments")

#-----------------Depuis les caracteristiques GPS-----------------#
GPS = c("event.id","timestamp","location.long","location.lat",
        "individual.local.identifier")


#=================création des subsets de nos variables sélectionnées=================#

CatAusCarac.shave = subset.data.frame(CatAusCarac,select =  Caracs)
CatAusGPS.shave = subset.data.frame(CatAusGPS,select =  GPS)
colnames(CatAusGPS.shave)[5] = "animal.id"

#--------------------------------------------------------------------------------#
# séparation de  :                                                               #
#"animal.comments" et  "manipulation.comments" en:                               #
# "Hunt", "N.pray" et "Hrs.indors", "N.neigbours"                                #
#--------------------------------------------------------------------------------#

#-----------------création du tableau vide de sortie : -----------------# 

NewRows = matrix(nrow = length(CatAusCarac.shave[,1]), ncol = 10)
colnames(NewRows) = c("animal.id","Hunt", "N.pray", "Hrs.indors", "N.neigbours",
                      "StartDate","StartHours","EndDate","EndHours","animal.age")

#-----------------création des patterns : -----------------# 

#_________________Pattern pour séparer le booléen de l'état de chasse et le nombre de proie_________________#
hunt.pattern = "Hunt:\\s*(Yes|No)"
prey.pattern = "prey_p_month:\\s*(\\d+)"

#_________________Pattern pour séparer le nombre d'heure à l'interieur et le nombre de chats cotoyées_________________#
hrs.pattern = "hrs_indoors:\\s*(\\d+)"
cats.pattern = "n_cats:\\s*(\\d+)"

#_________________Pattern pour séparer les heure des jours/mois_________________#
date_pattern = "(\\d{4}-\\d{2}-\\d{2})"
time_pattern = "(\\d{2}:\\d{2}:\\d{2}\\.\\d{3})"

#_________________Pattern pour transformer par exemple : "6 years" en 6_________________#
year.pattern = "\\d+(\\.\\d+)?(?=\\s*(years?))"

#-----------------Utilisation d'une boucle pour appliquer le pattern à chaque ligne des caracs : -----------------# 

for (i in 1:length(CatAusCarac.shave[,1])){
    ligne = subset(CatAusCarac.shave[i,], 
                   select = c("animal.comments","manipulation.comments",
                              "deploy.on.date","deploy.off.date", 
                              "animal.life.stage"))
    
    # usage de chaque pattern
    fooHunt = str_match(ligne[1], hunt.pattern)[2]        # chasse?
    fooPray = str_match(ligne[1], prey.pattern)[2]        # nombre de proie
    fooHrs = str_match(ligne[2], hrs.pattern)[2]          # nombre d'heure intérieure
    fooCats = str_match(ligne[2], cats.pattern)[2]        # nombre de chats côtoyées
    fooStartDate = str_match(ligne[3], date_pattern)[2]   # date de début
    fooStartHours = str_match(ligne[3], time_pattern)[2]  # heure de début
    fooEndDate = str_match(ligne[4], date_pattern)[2]     # date de fin
    fooendHours = str_match(ligne[4], time_pattern)[2]    # heure de fin
    fooyears = str_match(ligne[5], year.pattern)[1]       # âge de l'animal
    fooID = CatAusCarac.shave[i,]$animal.id
    
    # on applique les données extraites par ligne
    NewRows[i,] = c(fooID,fooHunt,fooPray,fooHrs,fooCats,fooStartDate,
                    fooStartHours,fooEndDate,fooendHours,fooyears)
}


#-----------------application des résultats dans le tableau de départ-----------------#

FullAusCarac = left_join(CatAusCarac.shave, data.frame(NewRows),
                         by = "animal.id") 

#-----------------replacer les valeurs vides ("") par des NA-----------------#

FullAusCarac[FullAusCarac == "" | FullAusCarac == " " | is.na(FullAusCarac) ] = "NA"

#-----------------Suppression des vielles colonnes divisées par les REs-----------------#

FullAusCarac = FullAusCarac[,-4] ;  # suppression de animal.comments
FullAusCarac = FullAusCarac[,-7];   # suppression de manipulation.comments
FullAusCarac = FullAusCarac[,-2:-3] # suppression de l'ancien formatage de la date + hours (pour début et fin)
FullAusCarac = FullAusCarac[,-2]    # suppression de de l'ancien formatage pour "animal.life.stage"

#-----------------remplacement de certaines valeurs qualitatives tel que "M" ou "F" pae 1 et 0 : -----------------#

#_________________création de la matrice_________________#
genre.replacement = c("m"=0,"f"=1, "NA"= -1)
hunt.replacement = c("No"=0,"Yes"=1,"NA"=-1)
reproductive.replacement = c("Neutered"=0,"Spayed"=0,"Fixed"=0,
                             "Not Fixed"=1, "NA"=-1)

# Neutered = castration pour mâle
# spayed = castration femelle
# fixed = peut plus reproduction (terme général)
# Not fixed = peut avoir enfants (pas de castration)

#_________________applacation de la matrice_________________#

# pour "sex"
FullAusCarac = FullAusCarac %>%
    mutate(animal.sex = recode(as.character(FullAusCarac$animal.sex),
                               !!!genre.replacement))

# pour "Hunt"
FullAusCarac = FullAusCarac %>%
    mutate(Hunt = recode(as.character(FullAusCarac$Hunt),
                         !!!hunt.replacement))

# sur "reproductive.condition"
FullAusCarac = FullAusCarac %>%
    mutate(animal.reproductive.condition = recode(as.character(
        FullAusCarac$animal.reproductive.condition), !!!reproductive.replacement))

# sur "age" et les autres en "NA"
FullAusCarac$animal.age[FullAusCarac$animal.age == "NA"] = -1

# export
write.csv(FullAusCarac, "../data/OutCatdataCaracQuanti.csv")



#=================concatenate the data table with the GPS info's table=================#

FullDataset.Cat = full_join(CatAusGPS.shave, FullAusCarac,
                            by = "animal.id")
## print the .csv in output

write.csv(FullDataset.Cat, "../data/OutCatdataQuantitativ.csv")



