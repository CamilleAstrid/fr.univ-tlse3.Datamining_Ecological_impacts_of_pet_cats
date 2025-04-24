<p align="center">
<img src="../data/pictures/logo_blanc.png" alt="logo_Felinomicon" width="200" />
<p/>
  
# Préparation des données d'analyse

## Données utilisées
Les données seront récupérées du dossier [data](https://github.com/CamilleAstrid/fr.univ-tlse3.Datamining_Ecological_impacts_of_pet_cats/edit/main/data). Nous allons utiliser les données obtenues à partir des relevés GPS ([PetCatsAustraliaGPS](https://github.com/CamilleAstrid/fr.univ-tlse3.Datamining_Ecological_impacts_of_pet_cats/edit/main/data/PetCatsAustraliaGPS)) et celles sur les caractéristiques des sujets d'étude ([PetCatsAustraliaCaract](https://github.com/CamilleAstrid/fr.univ-tlse3.Datamining_Ecological_impacts_of_pet_cats/edit/main/data/PetCatsAustraliaCaract))

## Utilisation

Pour certaines analyses, les données devront être au format qualitatif et ne pas présenter de données quantitatives. Il faut alors lancer l'exécution du fichier [```Preparator.R```](https://github.com/CamilleAstrid/fr.univ-tlse3.Datamining_Ecological_impacts_of_pet_cats/edit/main/data.preparation/Preparator.R), pour des variables qualitatives, et [```PreparatorQuantitativ.R```](https://github.com/CamilleAstrid/fr.univ-tlse3.Datamining_Ecological_impacts_of_pet_cats/edit/main/data.preparation/PreparatorQuantitativ.R), pour les variables quantitatives. Pour une visualisation du comportement de ces scripts sur le jeu de données, il faut ouvrir le fichier : [DataAnalysisCats.Rmd](https://github.com/CamilleAstrid/fr.univ-tlse3.Datamining_Ecological_impacts_of_pet_cats/edit/main/data.preparation/DataAnalysisCats.Rmd).

Pour l'utiliser sur votre propre jeu de données, il faut modifier le chemin pour récupérer les fichiers en début de script.

🚧 _Amélioration envisagée :_ permettre à l'utilisateur de renseigner en argument le fichier pour le traitement.

## Matrice individus-variables
La préparation des données vise à diminuer le nombre d'informations redondantes et à retirer celles non informatives. Puis, le script convertit les données en quantitatives ou qualitatives selon le script exécuté.

Une fois la matrice individus-variables créée, une analyse prédictive sera réalisée à l'aide d'un entraînement de modèle et de son évaluation.

* matrice individu-variable quantitative : [OutCatdataQuantitativ.csv](https://github.com/CamilleAstrid/fr.univ-tlse3.Datamining_Ecological_impacts_of_pet_cats/edit/main/data/OutCatdataQuantitativ.csv)
* matrice individu-variable qualitative : [OutCatdata.csv](https://github.com/CamilleAstrid/fr.univ-tlse3.Datamining_Ecological_impacts_of_pet_cats/edit/main/data/OutCatdata.csv)

## Visualisation des données
Pour savoir quel modèle utilisé et quelles variables conserver, il faut s'appuyer sur les résultats obtenus à l'aide du script : [TrueDataAnalysisCats.Rmd](https://github.com/CamilleAstrid/fr.univ-tlse3.Datamining_Ecological_impacts_of_pet_cats/edit/main/data.preparation/TrueDataAnalysisCats.Rmd). La visualisation des données à l'aide de graphiques, permet de mieux se figurer l'orientation que doit prendre la suite de l'analyse.

## Suite de l'analyse
Une comparaison de divers modèle d'apprentissage sera utilisée. Nous évaluerons la performance de [Knime](https://www.knime.com/), du package python [sklearn](https://scikit-learn.org/stable/) et du package R [MASS](https://cran.r-project.org/web/packages/MASS/index.html).

Une fois le modèle généré, une vérification de sa robustesse sera réalisée à l'aide du jeu de données sur les sujets français.

---
> [!IMPORTANT]
> Des modifications à la matrice (et donc aux scripts pour l'obtenir) pourront avoir lieu par la suite, si elle ne s'avérait pas parfaitement adaptée ou incomplète par rapport à l'analyse prévue.
