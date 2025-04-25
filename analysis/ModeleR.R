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

## Plots de la répartition en fonction d'un caractère

### Chasse ~ sexe
g <- tb.Caract %>% 
  ggplot(aes(x=animal.sex)) +
  geom_density(aes(fill=Hunt), alpha=0.35)  +
  theme_bw()

ggsave(filename = "Densite_animal.sex-Hunt.png", plot = g)

### Chasse ~ age
g <- tb.Caract %>% 
  ggplot(aes(x=animal.age)) +
  geom_density(aes(fill=Hunt), alpha=0.35)  +
  theme_bw()

ggsave(filename = "Densite_animal.age-Hunt.png", plot = g)

### Chasse ~ sterilisation
g <- tb.Caract %>% 
  ggplot(aes(x=animal.reproductive.condition)) +
  geom_density(aes(fill=Hunt), alpha=0.35)  +
  theme_bw()

ggsave(filename = "Densite_animal.reproductive.condition-Hunt.png", plot = g)


g <- tb.Caract %>%
  ggplot(aes(x=animal.reproductive.condition, fill=Hunt)) + # aes pour aesthetic
  geom_bar(stat = 'count') + # https://ggplot2.tidyverse.org/reference/geom_bar.html
  scale_fill_manual(values = c("Yes" = "darkgreen", "No" = "darkred", "Unknown" = "lightgrey")) +
  theme_minimal()

ggsave(filename = "Barplot_Chasseurs-animal.reproductive.condition.png", plot = g)

### Chasse ~ nbre de chats dans le foyer
g <- tb.Caract %>% 
  ggplot(aes(x=N.neigbours)) +
  geom_density(aes(fill=Hunt), alpha=0.35)  +
  theme_bw()

ggsave(filename = "Densite_N.neigbours-Hunt.png", plot = g)

g <- tb.Caract %>%
  ggplot(aes(x=N.neigbours, fill=Hunt)) + # aes pour aesthetic
  geom_bar(stat = 'count') + # https://ggplot2.tidyverse.org/reference/geom_bar.html
  scale_fill_manual(values = c("Yes" = "darkgreen", "No" = "darkred", "Unknown" = "lightgrey")) +
  theme_minimal()

ggsave(filename = "Barplot_Chasseurs-N.neigbours.png", plot = g)


# Calcul des moyennes et écart-types par classe 

tb.Caract %>% 
  group_by(Hunt) %>%
  summarise(animal.sex.mean = mean(animal.sex), animal.sex.sd = sd(animal.sex))

tbg1 = tb.Caract
tbg1 %<>%
  mutate(HuntFoo=as.factor(tbg1$Hunt))

tbg1[,"Hunt"] = tbg1[,"animal.reproductive.condition"]
tbg1[,"animal.reproductive.condition"] = tbg1[,"HuntFoo"]
tbg1 = tbg1[,-14] # supprimer colonne temporaire
colonne_names = colnames(tbg1)
colonne_names[3] = "Hunt"
colonne_names[5] = "Sterilisation"
colnames(tbg1)=colonne_names
for (i in 1:2){
  tbg1 = tbg1[,-1] # supprimer colonnes X, animal.id
}
for (i in 1:4){
  tbg1 = tbg1[,-7] # supprimer colonnes StartDate, StartHours, EndDate, EndHours
  
}

tbg = tbg1 %>%
  rowid_to_column() %>%
  pivot_longer(animal.sex : animal.age, names_to='variable', values_to='value')

tbg %>%
  ggplot(aes(x = Hunt, y =  log(value), color=Hunt)) +
  geom_boxplot() +
  facet_wrap(~ variable)

# Normalisation
## Retirer les NA
tbg = as.data.frame(tbg)
index = 1
while (index>length(tbg[,1])) {
  if (is.na(tbg[i,4]) | tbg[i,4]=="" | tbg[i,4]==" " | tbg[i,4]=='NA'){
    tbg = tbg[-i,]
  }
  else
    index = index + 1
}
## Création du Z-score
znorm = tbg %>%
  group_by(variable) %>%
  summarize(mean=mean(value),
            sd=sd(value),
            min = min(value),
            max=max(value),
            median=median(value)
            )
## Jointure des z-scores
tbg %<>% 
  inner_join(znorm, by='variable') %>% 
  mutate(value.z = (value-mean)/sd)
## Vérification
g <- tbg %>% 
  group_by(variable) %>% 
  summarize(moyenne=round(mean(value.z), 4), `écart-type`=sd(value.z))

ggsave(filename = "Boxplots_Chasseurs_NonNormalisation.png", scale = 2, plot = g)
# Formatage des données
znorm %>% 
  knitr::kable()

# Visualisation normalisée
g <- tbg %>%
  ggplot(aes(Hunt, value.z, color=Hunt)) +
  geom_violin() +
  geom_jitter(alpha=.3, width=.15, size=0.5, shape = 3) +
  facet_wrap(~ variable)

ggsave(filename = "Boxplots_Chasseurs_Normalisation.png", scale = 2, plot = g)

# Transformation des données
tbz = tbg %>% 
  select(rowid, Hunt, variable, value.z) %>%
  pivot_wider(names_from = variable, values_from=value.z)

# Nuages de points
g <- tbz %>%
  ggpairs(aes(color=Hunt, alpha=0.1))

ggsave(filename = "Analyses_bivariees.png", scale = 3, plot = g)

# Matrices de corrélations
g <- tb %>%
  select(-Hunt) %>%
  ggcorr()

ggsave(filename = "Matrice_de_correlation.png", scale = 3, plot = g)

g <-tbz %>%
  select(-Hunt) %>%
  ggcorr()

ggsave(filename = "Matrice_de_correlation_Normalisation.png", scale = 3, plot = g)

# ACP
## Supprimer les lignes avec NA
tb = read.csv(file = "../data/OutCatdataQuantiNormZ.csv")
for (index_ligne in 1:length(tb[,1])){
  for (index_colonne in 1:length(tb[1,])){
    if (is.na(tb[index_ligne,index_colonne]))
      tb = tb[-index_ligne,]
  }
}
write.csv(tb, file = "../data/OutCatdataQuantiNormZNoNA.csv")
tb.acp = tb %>% 
  select(-Hunt) %>% 
  as.matrix %>% 
  princomp(cor=T)
g <- tb.acp %>% summary
write(g, file = "export_tb.acp_summary.txt")

g <- tb.acp %>%
  fviz_screeplot(addlabels = TRUE, ylim = c(0, 50))

ggsave(filename = "Eboulis_des_valeurs_propres.png", scale = 2, plot = g)



