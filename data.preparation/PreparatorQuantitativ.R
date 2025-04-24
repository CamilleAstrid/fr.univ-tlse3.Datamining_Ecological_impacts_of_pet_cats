library(tidyverse);  library(GGally); library(stringr)

# this setwd() only works for Rstudio.
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


################################################################################
# open datasets : 
################################################################################

CatAus = read.csv("../data/PetCatsAustralia.csv"
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

NewRows = matrix(nrow = length(CatAusCarac.shave[,1]), ncol = 10)
colnames(NewRows) = c("animal.id","Hunt", "N.pray", "Hrs.indors", "N.neigbours",
                      "StartDate","StartHours","EndDate","EndHours","animal.age")

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

# the patern to transform "6 years" into 6 : 
year.pattern = "\\d+(\\.\\d+)?(?=\\s*(years?))"

## 3. using a for loop to apply each pattern in order to extract the data

for (i in 1:length(CatAusCarac.shave[,1])){
    ligne = subset(CatAusCarac.shave[i,], 
                   select = c("animal.comments","manipulation.comments",
                              "deploy.on.date","deploy.off.date", 
                              "animal.life.stage"))
    
    # usage de chaque pattern
    fooHunt = str_match(ligne[1], hunt.pattern)[2]
    fooPray = str_match(ligne[1], prey.pattern)[2]
    fooHrs = str_match(ligne[2], hrs.pattern)[2]
    fooCats = str_match(ligne[2], cats.pattern)[2]
    fooStartDate = str_match(ligne[3], date_pattern)[2]
    fooStartHours = str_match(ligne[3], time_pattern)[2]
    fooEndDate = str_match(ligne[4], date_pattern)[2]
    fooendHours = str_match(ligne[4], time_pattern)[2]
    fooyears = str_match(ligne[5], year.pattern)[1]
    fooID = CatAusCarac.shave[i,]$animal.id
    # on applique les données extraites par ligne (l'interêt de la boucle)
    NewRows[i,] = c(fooID,fooHunt,fooPray,fooHrs,fooCats,fooStartDate,
                    fooStartHours,fooEndDate,fooendHours,fooyears)
}

## 4. applying the resulting data inside the cat's data table

FullAusCarac = left_join(CatAusCarac.shave, data.frame(NewRows),
                         by = "animal.id") 

## 4.5 replacing "" and " " with NA

FullAusCarac[FullAusCarac == "" | FullAusCarac == " " | is.na(FullAusCarac) ] = "NA"

## 5. removing the old colums

FullAusCarac = FullAusCarac[,-4] ; # removing animal.comments
FullAusCarac = FullAusCarac[,-7]; # removing manipulation.comments
FullAusCarac = FullAusCarac[,-2:-3] # removing the date + hours (begin and end)
FullAusCarac = FullAusCarac[,-2] # removing the old formating for "animal.life.stage"

## 6. replacing qualitatives values such as M or F with 1 and 0 : 

## a) creating the matrix
genre.replacement = c("m"=0,"f"=1, "NA"= -1)
hunt.replacement = c("No"=0,"Yes"=1,"NA"=-1)
reproductive.replacement = c("Neutered"=0,"Spayed"=0,"Fixed"=0,
                             "Not Fixed"=1, "NA"=-1)

# Neutered = castration for male
# spayed = castration female
# fixed = peut plus baise (terme général)
# Not fixed = peut avoir enfants

## b) appling the matrix

# to sex
FullAusCarac = FullAusCarac %>%
    mutate(animal.sex = recode(as.character(FullAusCarac$animal.sex),
                               !!!genre.replacement))

# to hunt
FullAusCarac = FullAusCarac %>%
    mutate(Hunt = recode(as.character(FullAusCarac$Hunt),
                         !!!hunt.replacement))

# to reproduction
FullAusCarac = FullAusCarac %>%
    mutate(animal.reproductive.condition = recode(as.character(
        FullAusCarac$animal.reproductive.condition), !!!reproductive.replacement))

# to age and all the others "NA"
FullAusCarac$animal.age[FullAusCarac$animal.age == "NA"] = -1

# export
write.csv(FullAusCarac, "../data/OutCatdataCaracQuanti.csv")

################################################################################
#concatenate the data table with the GPS info's table
################################################################################

FullDataset.Cat = full_join(CatAusGPS.shave, FullAusCarac,
                            by = "animal.id")



## print the .csv in output

write.csv(FullDataset.Cat, "../data/OutCatdataQuantitativ.csv")



