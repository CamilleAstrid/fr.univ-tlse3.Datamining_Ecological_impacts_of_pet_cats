##################################################################################
# BAC A SABLE
mat = as.array(matrix(c(rep(1,999),NA),1e4,14))
mat = cleanData(mat, colnames(mat))

mat2 = as.array(matrix(c(rep(1,3),NA),6,6))
mat2
listName = c("a", "b", "c", "d", "e", "f")
colnames(mat2) = listName
rownames(mat2) = listName
mat2
mat2 = cleanData(mat2, c("a", "b", "c", "d", "e"))
mat2

fooNames = colnames(tb)
unique(match("N.pray", fooNames))
typeof(tb[80221,"N.pray"])
is.na(tb[80221,"N.pray"])
typeof(NA)
typeof(NULL)

pos_list <- list()
for (colonne in pos_col){
  indice = match(colonne, colnames(tableau))
  pos_list = append(pos_list, indice)
}
##################################################################################



#=================Chargement des librairies=================####
library(tidyverse)
library(magrittr)   # syntaxe, notamment affectation %<>%
library(GGally)     # plot pairs better than default plot
library(plotly)     # plots interactifs
library(factoextra) # visualisation ACP
library(progress)   # visualisation de l'avancée du traitement
library(beepr)      # Notifier la fin du traitement
library(uwot)       # utilisation pour umap
library(grid)       # utilisation pour umap
library(gridExtra)  # utilisation pour umap
library(stats)      # pour le clustering
library(docstring)  # "c'est comme le Port-Salut, c'est écrit dessus" --1961
library(MASS)       # pour l'analyse discriminante
library(caret)      # pour la vérif pertinence modèle (prédiction)



#=================Fonctions=================#####
cleanData <- function(tableau, pos_col){
  #####
  #' Fonction cleanData
  #' 
  #' @description Fonction permettant de supprimer les valeurs nulles (NA)
  #' 
  #' @param tableau array. Correspond au tableau à traiter.
  #' @param pos_col vector. Correspond aux noms des colonnes à traiter.
  #' \subsection{Attention}{
  #' Ce vecteur est composé de chaînes de caractères et non de valeurs numériques.
  #' }
  #' 
  #' @usage
  #' cleanData(tableau, pos_col)
  #' cleanData(tableau)
  #' 
  #' @return aucun. La fonction travaille directement sur le tableau.
  #' 
  #' @references https://r-coder.com/progress-bar-r/
  #' \subsection{Utilisation}{
  #' Leur code permet de visualiser une barre de progression et donc de s'assurer
  #' que l'algorithme tourne toujours dans le cas d'un volume de données conséquent.
  #' Nos remerciements aux développeurs.
  #' }
  #' 
  #' @note
  #' Le temps de calcul peut être très important, il est recommandé d'utiliser
  #' le GPU de la machine.
  #' 
  #' @export
  #' @importFrom
  #####
  beep("ready")
  docstring(cleanData)
  listeIndexNA = list() ; n_iter = length(tableau[,1])
  pb <- progress_bar$new(format = "(:spin) <:bar> :percent Reading... [Elapsed time: :elapsedfull || Estimated time remaining: :eta]",
                          total = n_iter,
                          complete = "=",   # Completion bar character
                          incomplete = "-", # Incomplete bar character
                          current = "0",    # Current bar character
                          clear = FALSE,    # If TRUE, clears the bar when finish
                          width = 100)      # Width of the progress bar
  for(i in 1:n_iter) {
    pb$tick() # Updates the current state
    #___
    # Code to be executed
    #___
    pos_list <- list()
    for (colonne in pos_col){
      indice = match(colonne, colnames(tableau))
      pos_list = append(pos_list, indice)
    }
    for (element in pos_list){
      if (is.na(tableau[i, element])){
        listeIndexNA = append(listeIndexNA, i)
        break
      }
    }
  }
    #___
  beep("complete")
  
  n_iter = length(listeIndexNA)
  pb <- progress_bar$new(format = "(:spin) <:bar> :percent Writing... [Elapsed time: :elapsedfull || Estimated time remaining: :eta]",
                         total = n_iter,
                         complete = "=",   # Completion bar character
                         incomplete = "-", # Incomplete bar character
                         current = "0",    # Current bar character
                         clear = FALSE,    # If TRUE, clears the bar when finish
                         width = 100)      # Width of the progress bar
  IndexNA = listeIndexNA[rev(1:length(listeIndexNA))]
  for(i in IndexNA) {
    pb$tick() # Updates the current state
    #___
    # Code to be executed
    #___
    i = as.numeric(i)
    tableau = tableau[-i,]
  }
    #___
  beep("fanfare")
  return(tableau)
}
  
prePurEnt <- function(k, tableau, classeName, typeAnalyse){
  #####
  #' Fonction prePurEnt
  #' 
  #' @description Fonction permettant d'obtenir la pureté associée à plusieurs kmeanS.
  #' 
  #' @param taille vector. Correspond aux valeurs de kmeans pour faire le test de pureté.
  #' \subsection{Par défaut}{
  #' taille = seq(2,20)
  #' Le vecteur prend des valeurs de kmeans de 2 à 20 avec un pas de 1.
  #' }
  #' \subsection{Attention}{
  #' Ce vecteur est composé de valeurs numériques et non de chaînes de caractères.
  #' }
  #' @param tableau array. Correspond au tableau à traiter.
  #' @param classeName character. Correspond au nom de la colonnes où figure les classes.
  #' \subsection{Attention}{
  #' Ce vecteur est composé de chaînes de caractères et non de valeurs numériques.
  #' }
  #' 
  #' @usage
  #' purities(taille, tableau, classeName)
  #' purities(tableau, classeName)
  #' 
  #' @return list. Les valeurs de pureté associées aux kmeans.
  #' 
  #' @import function. purity()
  beep("ready")
  classes = classeName
  km = df %>% kmeans(centers=k)
  clusters = km$cluster
  cm = tapply(classes, clusters, summary) %>% simplify2array()
  ni = colSums(cm)
  pij = t(cm)/ni
  if (typeAnalyse == "purity"){
    pi = apply(pij, 1, max)
    wi = ni/sum(ni)
    res = sum(wi*pi)
  }
  else
    res = pij*log(pij)

  beep("complete")
  return(res)
}

purity <- function(k, tableau, classeName){
  #####
  #' Fonction purity
  #' 
  #' @description Fonction permettant de mesurer la pureté des clusters et
  #' donc de la bonne répartition des individus dans leur groupe respectif.
  #' 
  #' @param k int. Correspond à la valeur de kmeans pour faire le test de pureté.
  #' @param tableau array. Correspond au tableau à traiter.
  #' @param classeName character. Correspond au nom de la colonnes où figure les classes.
  #' \subsection{Attention}{
  #' Ce vecteur est composé de chaînes de caractères et non de valeurs numériques.
  #' }
  #' 
  #' @usage purity(k, tableau, classeName)
  #' 
  #' @return numeric. La valeur de la pureté associée au kmeans.
  #' 
  #####
  res = prePurEnt(k, tableau, classeName, "purity")
  return(res)
}

purities <- function(taille = seq(2,20), tableau, classeName){
  #####
  #' Fonction purities
  #' 
  #' @description Fonction permettant d'obtenir la pureté associée à plusieurs kmeanS.
  #' 
  #' @param taille vector. Correspond aux valeurs de kmeans pour faire le test de pureté.
  #' \subsection{Par défaut}{
  #' taille = seq(2,20)
  #' Le vecteur prend des valeurs de kmeans de 2 à 20 avec un pas de 1.
  #' }
  #' \subsection{Attention}{
  #' Ce vecteur est composé de valeurs numériques et non de chaînes de caractères.
  #' }
  #' @param tableau array. Correspond au tableau à traiter.
  #' @param classeName character. Correspond au nom de la colonnes où figure les classes.
  #' \subsection{Attention}{
  #' Ce vecteur est composé de chaînes de caractères et non de valeurs numériques.
  #' }
  #' 
  #' @usage
  #' purities(taille, tableau, classeName)
  #' purities(tableau, classeName)
  #' 
  #' @return list. Les valeurs de pureté associées aux kmeans.
  #' 
  #' @import function. purity()
  #####
  res = sapply(taille, function(k){purity(k, tableau, classeName)})
  beep("fanfare")
  return(res)
}

entropy <- function(k,tableau, classeName){
  res = prePurEnt(k, tableau, classeName, "entropy")
  return(res)
}

entropies <- function(taille = seq(2,20), tableau, classeName){
  res = sapply(taille, function(k){entropy(k, tableau, classeName)})
  beep("fanfare")
  return(res)
}

#=================Chargement des données=================#####
tb = read.table('../data/OutCatdataQuantitativ.csv', header = TRUE,  sep = ',',  stringsAsFactors = FALSE)



#=================Définition des facteurs=================#####
hunt.replacement = c( "0"="No", "1"="Yes", "-1"="Unknown")
tb = tb %>%
  mutate(Hunt = recode(as.character(tb$Hunt),
                       !!!hunt.replacement))
tb %>%
  mutate(class=as.factor(Hunt))



#=================Visualisation avec ggplot2=================#####
#-----------------Barplot des individus dans chaque classe-----------------#####
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

ggsave(filename = "data/pictures/Barplot_Chasseurs.png", plot = g)


#-----------------Plots de la répartition en fonction d'un caractère-----------------#####

#_________________Chasse ~ sexe_________________#####
g <- tb.Caract %>% 
  ggplot(aes(x=animal.sex)) +
  geom_density(aes(fill=Hunt), alpha=0.35)  +
  theme_bw()
ggsave(filename = "data/pictures/Densite_animal.sex-Hunt.png", plot = g)

#_________________Chasse ~ age_________________#####
g <- tb.Caract %>% 
  ggplot(aes(x=animal.age)) +
  geom_density(aes(fill=Hunt), alpha=0.35)  +
  theme_bw()
ggsave(filename = "data/pictures/Densite_animal.age-Hunt.png", plot = g)

#_________________Chasse ~ sterilisation_________________#####
g <- tb.Caract %>% 
  ggplot(aes(x=animal.reproductive.condition)) +
  geom_density(aes(fill=Hunt), alpha=0.35)  +
  theme_bw()
ggsave(filename = "data/pictures/Densite_animal.reproductive.condition-Hunt.png", plot = g)

g <- tb.Caract %>%
  ggplot(aes(x=animal.reproductive.condition, fill=Hunt)) + # aes pour aesthetic
  geom_bar(stat = 'count') + # https://ggplot2.tidyverse.org/reference/geom_bar.html
  scale_fill_manual(values = c("Yes" = "darkgreen", "No" = "darkred", "Unknown" = "lightgrey")) +
  theme_minimal()
ggsave(filename = "data/pictures/Barplot_Chasseurs-animal.reproductive.condition.png", plot = g)

#_________________Chasse ~ nbre de chats dans le foyer_________________#####
g <- tb.Caract %>% 
  ggplot(aes(x=N.neigbours)) +
  geom_density(aes(fill=Hunt), alpha=0.35)  +
  theme_bw()
ggsave(filename = "data/pictures/Densite_N.neigbours-Hunt.png", plot = g)

g <- tb.Caract %>%
  ggplot(aes(x=N.neigbours, fill=Hunt)) + # aes pour aesthetic
  geom_bar(stat = 'count') + # https://ggplot2.tidyverse.org/reference/geom_bar.html
  scale_fill_manual(values = c("Yes" = "darkgreen", "No" = "darkred", "Unknown" = "lightgrey")) +
  theme_minimal()
ggsave(filename = "data/pictures/Barplot_Chasseurs-N.neigbours.png", plot = g)



#=================Calcul des moyennes et écart-types par classe=================#####
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



#=================Normalisation=================#####

#-----------------Retirer les NA-----------------#####
tbg = as.data.frame(tbg)
index = 1 ; taille = length(tbg[,1])
while(index <= taille){
  if (is.na(tbg[index,4])){
    tbg = tbg[-index,]
    taille = taille - 1
  }
  else{
    index = index + 1
  }
}


#-----------------Création du Z-score-----------------#####
znorm = tbg %>%
  group_by(variable) %>%
  summarize(mean=mean(value),
            sd=sd(value),
            min = min(value),
            max=max(value),
            median=median(value)
            )


#-----------------Jointure des z-scores-----------------#####
tbg %<>% 
  inner_join(znorm, by='variable') %>% 
  mutate(value.z = (value-mean)/sd)


#-----------------Vérification-----------------#####
g <- tbg %>% 
  group_by(variable) %>% 
  summarize(moyenne=round(mean(value.z), 4), `écart-type`=sd(value.z))

fileConn <- file('data/files/export_verification_normalisation.csv')
capture.output(g, file = "data/files/export_verification_normalisation.csv", append = F)
close(fileConn)



#=================Visualisation normalisée=================#####
g <- tbg %>%
  ggplot(aes(Hunt, value.z, color=Hunt)) +
  geom_violin() +
  geom_jitter(alpha=.3, width=.15, size=0.5, shape = 3) +
  facet_wrap(~ variable)
ggsave(filename = "data/pictures/Boxplots_Chasseurs_Normalisation.png", scale = 2, plot = g)



#=================Transformation des données=================#####
tbz = tbg %>% 
  select(rowid, Hunt, variable, value.z) %>%
  pivot_wider(names_from = variable, values_from=value.z)



#=================Nuages de points=================#####
g <- tbz %>%
  ggpairs(aes(color=Hunt, alpha=0.1))
ggsave(filename = "data/pictures/Analyses_bivariees.png", scale = 3, plot = g)



#=================Matrices de corrélations=================#####
g <- tb %>%
  select(-Hunt) %>%
  ggcorr()
ggsave(filename = "data/pictures/Matrice_de_correlation.png", scale = 3, plot = g)

g <-tbz %>%
  select(-Hunt) %>%
  ggcorr()
ggsave(filename = "data/pictures/Matrice_de_correlation_Normalisation.png", scale = 3, plot = g)



#=================ACP=================#####

#-----------------Supprimer les lignes avec NA (très très long)-----------------#####
tb = read.csv(file = "../data/OutCatdataQuantiNormZ.csv")
unique(is.na.data.frame(tb)) # Vérification de la présence de NA value
tb = cleanData(tableau = tb, pos_col = c("N.pray","Hrs.indors","N.neigbours"))
unique(is.na.data.frame(tb)) # Vérification de la présence de NA value

#_________________Ecriture, Lecture pour gain de temps lors des tests_________________#####
write.csv(tb, file = "../data/OutCatdataQuantiNormZNoNA.csv") # Ecriture des données dans un fichier pour limiter le temps de calcul

# Ligne à mettre en commentaires une fois le script finalisé
tb = read.csv(file = "../data/OutCatdataQuantiNormZNoNA.csv") # Lecture des données précédentes pour limiter le temps de calcul pendant les tests


#-----------------Calcul ACP-----------------#####
tb.acp = tb %>% 
  select(-Hunt) %>% 
  as.matrix %>% 
  princomp(cor=T)

fileConn <- file('data/files/export_tb.acp_summary.csv')
capture.output(summary(tb.acp), file = "data/files/export_tb.acp_summary.csv", append = F)
close(fileConn)



#-----------------Graphique pour choisir le nombre de composantes principales-----------------#####
g <- tb.acp %>%
  fviz_screeplot(addlabels = TRUE, ylim = c(0, 50))
ggsave(filename = "data/pictures/Eboulis_des_valeurs_propres.png", scale = 2, plot = g)


#-----------------Contributions des variables-----------------#####
g <- tb.acp %>% 
  fviz_pca_var(col.var="contrib",
               gradient.cols = c("#17202a", "#e74c3c"),
               repel = TRUE)
ggsave(filename = "data/pictures/Contribution-des-variables.png", scale = 2, plot = g)

#-----------------Ajout des coordonnées projetées-----------------#####
names(tb.acp$score[,1:2]) = c('Comp1','Comp2') 
tb$Comp1 = tb.acp$score[,1]
tb$Comp2 = tb.acp$score[,2]

#_________________Visualisation avec factoextra_________________#####
g <- tb.acp %>%
  fviz_pca_ind(label = "none", # hide individual labels
               habillage = tb$Hunt, # color by groups
               palette = c("#17202a", "#2ecc71", "#e74c3c"),
               addEllipses = TRUE # Concentration ellipses
  )
ggsave(filename = "data/pictures/ACP_normee_CatsAust_factoextra.png", scale = 3, plot = g)



#=================Clustering=================#####

#-----------------MDS (Multi-Dimensional Scaling)-----------------#####

#_________________Création de la matrice de distance_________________#####
mdist = tbz %>% 
  select(animal.sex:animal.age) %>% 
  dist(method="euclidean") 
mat = as.matrix(mdist)[1:10, 1:10] %>% round(2)

fileConn <- file('data/files/export_matrice-distance-euclidienne.csv')
capture.output(mat, file = "data/files/export_matrice-distance-euclidienne.csv", append = F)
close(fileConn)

#_________________MDS_________________#####
mds = cmdscale(mdist)

#_________________Ajout des coordonnées à tbz_________________#####
tbz = tbz%>% 
  mutate(mds.x=-mds[,1], mds.y=mds[,2])

#_________________Génération d'un premier plot_________________#####
pl.mds = tbz %>% 
  ggplot(aes(x=mds.x, y=mds.y, color=Hunt, shape=Hunt)) +
  geom_point() +
  theme(legend.position = "none") +
  ggtitle("MDS projection")
g <- pl.mds
ggsave(filename = "data/pictures/Projection_MDS.png", scale = 3, plot = g)


#######################################################################
#                             TO DO                                   #
#######################################################################
#.................ACP pour conservation des coordonnées des individus sur les 2 premières composantes.................#
unique(is.na.data.frame(tbz)) # Vérification de la présence de NA value
tbz = cleanData(tableau = tbz, pos_col = colnames(tbz)) # Suppression des NA
unique(is.na.data.frame(tbz)) # Vérification de la présence de NA value
tbz.acp = tbz %>% 
  select(animal.sex:animal.age) %>% 
  as.matrix %>% 
  princomp(cor=F)
#.................Ajout des coordonnées.................#####
tbz <- tbz %>% 
  bind_cols(data.frame(tbz.acp$scores[,1:2]))
#.................Génération du plot.................#####
pl.acp = tbz %>% 
  ggplot(aes(x=Comp.1, y=Comp.2, color=Hunt, shape=Hunt)) +
  geom_point() +
  theme(legend.position = "none") +
  ggtitle("PCA projection")
g <- pl.acp
ggsave(filename = "data/pictures/Projection_ACP.png", scale = 3, plot = g)
#.................Même chose avec UMAP.................#####
tbz.umap <- tbz %>% 
  select(animal.sex:animal.age) %>%
  umap
colnames(tbz.umap) <- c('umap.x', "umap.y")
tbz <- tbz %>% 
  bind_cols(tbz.umap)
pl.umap = tbz %>% 
  ggplot(aes(x=umap.x, y=umap.y, color=Hunt, shape=Hunt)) +
  geom_point() +
  theme(legend.position = "none") +
  ggtitle("UMAP projection")
g <- pl.umap
ggsave(filename = "data/pictures/Projection_UMAP.png", scale = 3, plot = g)
#.................Plot ACP vs MDS vs UMAP.................#####
g <- grid.arrange(pl.acp, pl.mds, pl.umap, ncol=3)
ggsave(filename = "data/pictures/Projection_ACP-MDS-UMAP.png", scale = 3, plot = g)


#-----------------Clustering-----------------#####

#_________________Nettoyage des données_________________#####
tb2 = tb[,-1] # Supprimer colonne X
#.................Création colonne temporaire.................#####
tb2 %<>%
  mutate(HuntFoo=as.factor(tb2$Hunt))
#.................Echange de position des colonnes.................#####
tb2[,"Hunt"] = tb2[,"location.long"]
tb2[,"location.long"] = tb2[,"HuntFoo"]
tb2 = tb2[,-14] # Supprimer colonne temporaire
#.................Renommer les colonnes.................#####
colonne_names = colnames(tbg1)
colonne_names[3] = "Hunt"
colonne_names[5] = "location.long"
colnames(tb2)=colonne_names
#.................Rendre à César ce qui appartient à César.................#####
tb = tb2

#_________________Méthode des kmeans_________________#####
k_tb = kmeans(tb[,-1], 3) # Sur tout le tableau (sans les classes) et en demandant 3 centres de clusters
fileConn <- file('data/files/export_methode-kmeans.csv')
capture.output(k_tb, file = "data/files/export_methode-kmeans.csv", append = F)
close(fileConn)


#-----------------Affichage du plot-----------------#####
df = tbz %>% select(animal.sex:animal.age)
km.3 = df %>% kmeans(centers=3)
tbz = tbz %>% mutate(kmeans.3=as.factor(c('A', 'B', 'C') [km.3$cluster]))
g = tbz
ggsave(filename = "data/pictures/Clustering_kmeans.png", scale = 3, plot = g)



#=================Evaluation avec mesure qualité non supervisée (coefficient de silhouette)=================#####

#--------------------------------------------------------------------------------#
# RAPPELS                                                                        #
# * elements: les coefficients de silhouette pour chaque individu                #
# * clusters: les coefficients de silhouette pour chaque cluster                 #
# * clustering: le coefficient de silhouette pour le clustering                  #
#                                                                                #
# Pour un individu :                                                             #
# * ai : distance moyenne aux objets du cluster                                  #
# * bi : minimum des distances moyennes de i aux objets d’un autre cluster       #
# * si = bi−ai/max(ai,bi)                                                        #
#                                                                                #
# Pour un cluster : moyenne des coefficients de silhouette de ses membres        #
#                                                                                #
# Pour un clustering ; moyenne des coefficents de tous les individus             #
#--------------------------------------------------------------------------------#

#-----------------Etude pour toutes les valeurs-----------------#####
mdist = tbz %>% select(animal.sex:animal.age) %>% dist(method = "euclidean")
silhouette <- function(x, clusters){
  d <- as.matrix(dist(x))
  si <- sapply(1:length(clusters), function(i){
    vi <- d[i,]
    ki <- clusters[i]
    di <- tapply(vi[-i], clusters[-i], mean)
    ai = min(tapply(vi[-i], clusters[-i], mean)[clusters[i]])
    bi = min(tapply(vi[-i], clusters[-i], mean)[-clusters[i]])
    si = (bi-ai)/max(ai, bi)
  })
  list(
    individuals = si,
    clusters = tapply(si, clusters, mean),
    clustering = mean(si)
  )
}
silhouette(df, km.3$cluster)



#=================Détermination du nombre de clusters=================#####

#-----------------Etude pour toutes les valeurs de k-----------------#####
allures <- sapply(2:20, function(k){
              km <- df %>% kmeans(centers=k)
              silhouette(df, km$cluster)$clustering
              })


#-----------------Visualisation-----------------#####
g <- (plot(x = 2:20, y = allures,
        xlab="Nombre de clusters (k)",
        ylab="Coefficient de silhouette",
        type = "b") +
      maxi = c(2:20)[which.max(allures)] +
      value_max = as.character(maxi) +
      abline(v = maxi, col = "red", lty = 2) +
      text(x = maxi+2, y=max(allures), labels = paste("k =",value_max), col = "red")
)
ggsave(filename = "data/pictures/Valeurs_kmeans.png", scale = 3, plot = g)



#=================Evaluation avec des mesures supervisées=================#####

#-----------------Etude pour tous les k (de 2 à 20) : pureté-----------------#####
classes = tbz$Hunt
purityValue = purities(tableau = tbz, classeName = classes)

g <- (plot.default(x = 2:20,
             y = purityValue,
             xlab="Nombre de clusters (k)",
             ylab="Pureté",
             type = "b") +
      moy = round(mean(purityValue), 2) +
      value_moy = as.character(moy) +
      abline(h = moy, col = "red", lty = 2) +
      ypos = moy - 0.2 +
      text(x = 10, y=ypos, labels = paste("moyenne =",value_moy), col = "red")
)
ggsave(filename = "data/pictures/etude_purete.png", scale = 3, plot = g)


#-----------------Etude pour tous les k (de 2 à 20) : entropie-----------------#####
entropyValue = entropies(tableau = tbz, classeName = classes)

g <- (plot.default(x = 2:20,
                   y = entropyValue,
                   xlab="Nombre de clusters (k)",
                   ylab="Pureté",
                   type = "b") +
        moy = round(mean(entropyValue), 2) +
        value_moy = as.character(moy) +
        abline(h = moy, col = "red", lty = 2) +
        ypos = moy - 0.2 +
        text(x = 10, y=ypos, labels = paste("moyenne =",value_moy), col = "red")
)
ggsave(filename = "data/pictures/etude_entropy.png", scale = 3, plot = g)



#=================Analyse discriminante=================#
mat <- tb %>% 
  select(animal.sex:animal.age) %>% as.matrix
y <- tb$Hunt
model=lda(x=mat,grouping=y)
fileConn <- file('data/files/model_analyse-discriminante.csv')
capture.output(model, file = "data/files/model_analyse-discriminante.csv", append = F)
close(fileConn)
g <- plot(model)
ggsave(filename = "data/pictures/model_analyse-discriminante.png", scale = 3, plot = g)



#=================Comparaison projections ACP avec LDA=================#
ld.proj <- scale( mat, center=T, scale=F ) %*% model$scaling %>% 
  as_tibble
tbProj <- tb %>% bind_cols(ld.proj)

pl1 = tbProj %>% 
  ggplot(aes(x=-Comp1, y=Comp2, color=Hunt, shape=Hunt)) + 
  geom_point() + 
  theme(legend.position = "none") +
  ggtitle('ACP projection')
pl2 = tbProj %>%
  ggplot(aes(x=LD1, y=LD2, color=Hunt, shape=Hunt)) + 
  geom_point() + 
  theme(legend.position = "none") +
  ggtitle('LDA projection')
g <- grid.arrange(pl1, pl2, ncol=2)
ggsave(filename = "data/pictures/comparaison_projection_ACP-LDA.png", scale = 3, plot = g)



#=================Analyse des performances=================#
n = nrow(mat)
training = sample(n, round(2*n/3)) # tirage aléatoire de 2/3 pour le jeu d'apprentissage
mat.train = mat[training,]
y.train = y[training]
mat.test = mat[-training,] # le reste pour le jeu de test
y.test = y[-training]
model.mass = lda(x=mat.train, grouping = y.train)

#-----------------Prediction-----------------#
prediction = predict(model.mass, mat.test)
fileConn <- file('data/files/prediction.csv')
capture.output(prediction, file = "data/files/prediction.csv", append = F)
close(fileConn)

#_________________Visualisation_________________#
predict_all = predict(model.mass, mat)

pl3 = ggplot(data.frame(prediction$x, class = prediction$class), aes(x=LD1, y=LD2, color=class, shape=class)) + 
  geom_point() + 
  labs(title = 'Projection des points prédits')
g <- pl3
ggsave(filename = "data/pictures/projection_points-predits.png", scale = 3, plot = g)

pl4 = ggplot(data.frame(predict_all$x, class = predict_all$class), aes(x=LD1, y=LD2, color=class)) +
  geom_point()+
  labs(title = "Projection de l'ensemble des points du jeu de données à travers la prédiction")
g <- pl4
ggsave(filename = "data/pictures/projection_ensemble-dataset_points-predits.png", scale = 3, plot = g)

g <- grid.arrange(pl2, pl4, ncol=2)
ggsave(filename = "data/pictures/comparaison_projection_prediction-LDA.png", scale = 3, plot = g)

#-----------------Vérification de la pertinence du modèle-----------------#
vectPred = predict_all$class
vectOri = tb$Hunt
confusMat <- confusionMatrix(vectPred, vectOri)
fileConn <- file('data/files/matrice-de-confusion.csv')
capture.output(confusMat, file = "data/files/matrice-de-confusion.csv", append = F)
close(fileConn)








beep("mario") #FIN DU SCRIPT
