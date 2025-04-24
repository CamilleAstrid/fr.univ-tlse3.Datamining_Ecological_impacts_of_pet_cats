# Chargement des librairies
library(tidyverse)
library(magrittr) # syntaxe, notamment affectation %<>%
library(GGally)   # plot pairs better than default plot
library(plotly)   # plots interactifs
library(factoextra)

# Chargement des données
tb = read.table('../data/OutCatdataQuantitativ.csv', header = TRUE,  sep = ',',  stringsAsFactors = FALSE)

# Définition des facteurs
hunt.replacement = c( "0"="No", "1"="Yes", "-1"="Unknown")
tb = tb %>%
  mutate(Hunt = recode(as.character(tb$Hunt),
                       !!!hunt.replacement))
tb %>%
  mutate(class=as.factor(Hunt))

# Visualisation avec ggplot2

## Barplot des individus dans chaque classe
tb.Caract = read.csv('../data/OutCatdataCaracQuanti.csv')

tb.Caract = tb.Caract %>%
  mutate(Hunt = recode(as.character(tb.Caract$Hunt),
                       !!!hunt.replacement))
tb.Caract %>%
  mutate(class=as.factor(Hunt))

g <- tb.Caract %>%
  ggplot(aes(x=Hunt, fill=Hunt)) + # aes pour aesthetic
  geom_bar(stat = 'count') + # https://ggplot2.tidyverse.org/reference/geom_bar.html
  geom_text(stat='count', aes(label=..count..), vjust=-1) + # pour afficher les effectifs
  scale_fill_manual(values = c("Yes" = "darkgreen", "No" = "darkred", "Unknown" = "lightgrey")) +
  theme_minimal()

ggsave(filename = "Barplot_Chasseurs.png", plot = g)

## Boxplot de la répartition en fonction d'un caractère
tb.Caract %>% 
  ggplot(aes(x=Hunt, y=animal.sex,
             col = Hunt)) +
  geom_boxplot() +
  geom_point(shape = 3)
