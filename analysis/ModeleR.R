# Chargement des librairies
library(tidyverse)
library(magrittr) # syntaxe, notamment affectation %<>%
library(GGally)   # plot pairs better than default plot
library(plotly)   # plots interactifs
library(factoextra)

tb = read.table('../data/OutCatdataQuantitativ.csv', header = TRUE,  sep = ',',  stringsAsFactors = FALSE)
c('NA', 'No', 'Yes')[tb$Hunt]%>%
    as.factor

tb %>%
  mutate(class=as.factor(c('NA', 'No', 'Yes'))[Hunt])
tb %<>%
  mutate(Hunt=as.factor(c('NA', 'No', 'Yes'))[Hunt])

suppressWarnings(tb %>%
  ggplot(aes(x=Hunt, fill=Hunt)) + # aes pour aesthetic
  geom_bar(stat = 'count') + # https://ggplot2.tidyverse.org/reference/geom_bar.html
  geom_text(stat='count', aes(label=..count..), vjust=-1) # pour afficher les effectifs
)

