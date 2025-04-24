library(tidyverse);  library(GGally); library(stringr)

# this setwd() only works for Rstudio.
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

################################################################################
# open datasets : 
################################################################################

CatAus = read.csv("../data/Pet Cats Australia.csv"
                  , stringsAsFactors = F)
CatAusGPS = read.csv("../data/PetCatsAustraliaGPS"
                     , stringsAsFactors = F)
CatAusCarac = read.csv("../data/PetCatsAustraliaCaract"
                       , stringsAsFactors = F)



##Select only the pertinent variables

# 1. from Cats craracteristics
Caracs = c( "animal.id","deploy.on.date","deploy.off.date","animal.comments",
            "animal.life.stage",  "animal.reproductive.condition","animal.sex",
            "manipulation.comments")
# 2. From the GPS table
GPS = c("event.id","timestamp","location.long","location.lat",
        "individual.local.identifier")

## creating subsets from our selected variables

CatAusCarac.shave = subset.data.frame(CatAusCarac,select =  Caracs)
CatAusGPS.shave = subset.data.frame(CatAusGPS,select =  GPS)
colnames(CatAusGPS.shave)[5] = "animal.id"

## separating : 
#"animal.comments" and  "manipulation.comments" int : 
# "Hunt", "N.pray" et "Hrs.indors", "N.neigbours"

## 1. creating the empty recieving dataframe : 

NewRows = matrix(nrow = length(CatAusCarac.shave[,1]), ncol = 9)
colnames(NewRows) = c("animal.id","Hunt", "N.pray", "Hrs.indors", "N.neigbours",
                      "StartDate","StartHours","EndDate","EndHours")

## 2. creating the pattern :

# the patern to separate the bool for hunting and the numbers of pray
hunt.pattern = "Hunt:\\s*(Yes|No)"
prey.pattern = "prey_p_month:\\s*(\\d+)"

# the patern to separate the numbers of hours form the number of cats sharing the same roof
hrs.pattern = "hrs_indoors:\\s*(\\d+)"
cats.pattern = "n_cats:\\s*(\\d+)"

# the patern to separate separating the date from teh time of the day
date_pattern = "(\\d{4}-\\d{2}-\\d{2})"
time_pattern = "(\\d{2}:\\d{2}:\\d{2}\\.\\d{3})"

## 3. using a for loop to apply each pattern in order to extract the data

for (i in 1:length(CatAusCarac.shave[,1])){
    ligne = subset(CatAusCarac.shave[i,], 
                   select = c("animal.comments","manipulation.comments",
                              "deploy.on.date","deploy.off.date"))
    # la ça va être "crispy"
    
    # usage de chaque pattern
    fooHunt = str_match(ligne[1], hunt.pattern)[2]
    fooPray = str_match(ligne[1], prey.pattern)[2]
    fooHrs = str_match(ligne[2], hrs.pattern)[2]
    fooCats = str_match(ligne[2], cats.pattern)[2]
    fooStartDate = str_match(ligne[3], date_pattern)[2]
    fooStartHours = str_match(ligne[3], time_pattern)[2]
    fooEndDate = str_match(ligne[4], date_pattern)[2]
    fooendHours = str_match(ligne[4], time_pattern)[2]
    fooID = CatAusCarac.shave[i,]$animal.id
    # on applique les données extraites par ligne (l'interêt de la boucle)
    NewRows[i,] = c(fooID,fooHunt,fooPray,fooHrs,fooCats,fooStartDate,
                    fooStartHours,fooEndDate,fooendHours)
}

## 4. applying the resulting data inside the cat's data table

FullAusCarac = left_join(CatAusCarac.shave, data.frame(NewRows),
                         by = "animal.id") 

## 5. removing the old colums

FullAusCarac = FullAusCarac[,-4] ; # removing animal.comments
FullAusCarac = FullAusCarac[,-7]; # removing manipulation.comments
FullAusCarac = FullAusCarac[,-2:-3] # removing the date + hours (begin and end)


## 6. concatenatng all the sterelisation under Yes or No

reproductive.replacement = c("Neutered"="Sterilized","Spayed"="Sterilized","Fixed"="Sterilized",
                             "Not Fixed"="Not Sterilized", "NA"="NA")

FullAusCarac = FullAusCarac %>%
    mutate(animal.reproductive.condition = recode(as.character(
        FullAusCarac$animal.reproductive.condition), !!!reproductive.replacement))

write.csv(FullAusCarac, "../data/OutCatCarac.csv")

################################################################################
#concatenate the data table with the GPS info's table
################################################################################

FullDataset.Cat = full_join(CatAusGPS.shave, FullAusCarac,
                            by = "animal.id")
################################################################################
# treat empty data :
################################################################################

# set -1 for number of neigbours and N.pray
FullDataset.Cat$N.neigbours[is.na(FullDataset.Cat$N.neigbours)] = "-1"
FullDataset.Cat$N.pray[is.na(FullDataset.Cat$N.pray)] = "-1"

# Set NA for the others data

FullDataset.Cat[FullDataset.Cat == ""] = 'None'
FullDataset.Cat[is.na(FullDataset.Cat)] = 'NA'

## print the .csv in output

write.csv(FullDataset.Cat, "../data/OutCatdata.csv")




