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

NewRows = matrix(nrow = length(CatAusCarac.shave[,1]), ncol = 9)
colnames(NewRows) = c("animal.id","Hunt", "N.pray", "Hrs.indors", "N.neigbours",
                      "StartDate","StartHours","EndDate","EndHours")

#-----------------création des patterns : -----------------# 

#_________________Pattern pour séparer le booléen de l'état de chasse et le nombre de proie_________________#
hunt.pattern = "Hunt:\\s*(Yes|No)"
prey.pattern = "prey_p_month:\\s*(\\d+)"

#_________________Pattern pour séparer le nombre d'heure à l'interieur et le nombre de chats cotoyées_________________#
hrs.pattern = "hrs_indoors:\\s*(\\d+)"
cats.pattern = "n_cats:\\s*(\\d+)"

#_________________Pattern pour séparer les minutes/heure des jours/mois_________________#
date_pattern = "(\\d{4}-\\d{2}-\\d{2})"
time_pattern = "(\\d{2}:\\d{2}:\\d{2}\\.\\d{3})"


#-----------------Utilisation d'une boucle pour appliquer le pattern à chaque ligne des caracs : -----------------# 

for (i in 1:length(CatAusCarac.shave[,1])){
    ligne = subset(CatAusCarac.shave[i,], 
                   select = c("animal.comments","manipulation.comments",
                              "deploy.on.date","deploy.off.date"))

    # usage de chaque pattern
    fooHunt = str_match(ligne[1], hunt.pattern)[2]        # chasse?
    fooPray = str_match(ligne[1], prey.pattern)[2]        # nombre de proie
    fooHrs = str_match(ligne[2], hrs.pattern)[2]          # nombre d'heure intérieure
    fooCats = str_match(ligne[2], cats.pattern)[2]        # nombre de chats côtoyées
    fooStartDate = str_match(ligne[3], date_pattern)[2]   # date de début
    fooStartHours = str_match(ligne[3], time_pattern)[2]  # heure de début
    fooEndDate = str_match(ligne[4], date_pattern)[2]     # date de fin
    fooendHours = str_match(ligne[4], time_pattern)[2]    # heure de fin
    fooID = CatAusCarac.shave[i,]$animal.id
    
    # on applique les données extraites par ligne 
    NewRows[i,] = c(fooID,fooHunt,fooPray,fooHrs,fooCats,fooStartDate,
                    fooStartHours,fooEndDate,fooendHours)
}


#-----------------application des résultats dans le tableau de départ-----------------#

FullAusCarac = left_join(CatAusCarac.shave, data.frame(NewRows),
                         by = "animal.id") 

#-----------------Suppression des vielles colonnes divisées par les REs-----------------#

FullAusCarac = FullAusCarac[,-4] ; # removing animal.comments
FullAusCarac = FullAusCarac[,-7]; # removing manipulation.comments
FullAusCarac = FullAusCarac[,-2:-3] # removing the date + hours (begin and end)


#-----------------Concaténation des stérilisation sous "Sterilized", "Not Sterilized" et NA-----------------#

reproductive.replacement = c("Neutered"="Sterilized","Spayed"="Sterilized","Fixed"="Sterilized",
                             "Not Fixed"="Not Sterilized", "NA"="NA")

FullAusCarac = FullAusCarac %>%
    mutate(animal.reproductive.condition = recode(as.character(
        FullAusCarac$animal.reproductive.condition), !!!reproductive.replacement))

write.csv(FullAusCarac, "../data/OutCatCarac.csv")



#=================concatenate the data table with the GPS info's table=================#

FullDataset.Cat = full_join(CatAusGPS.shave, FullAusCarac,
                            by = "animal.id")



#=================traitement des données vides=================#

#_________________-1 pour le nombre de voisin et de proie_________________#
FullDataset.Cat$N.neigbours[is.na(FullDataset.Cat$N.neigbours)] = "-1"
FullDataset.Cat$N.pray[is.na(FullDataset.Cat$N.pray)] = "-1"

#_________________NA pour toutes les autres données manquantes_________________#

FullDataset.Cat[FullDataset.Cat == ""] = 'None'
FullDataset.Cat[is.na(FullDataset.Cat)] = 'NA'

#=================export du .csv=================#

write.csv(FullDataset.Cat, "../data/OutCatdata.csv")




