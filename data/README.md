# Jeux de données

Ce répertoire doit contenir les fichiers de données de départ accompagnés de leur description (et l'indication de la provenance). Les données étant trop volumineuses, il faut les télécharger à l'aide des commandes indiquées dans le README.md présent à la racine ou à l'aide des commandes suivantes :

## Téléchargement

1. Jeu de données sur les chats
```
wget https://www.kaggle.com/api/v1/datasets/download/sujaykapadnis/ecological-impacts-of-pet-cats
unzip ecological-impacts-of-pet-cats -d data
rm ecological-impacts-of-pet-cats
```

/!\ Les données seront à télécharger à l'aide des commandes précédentes depuis la racine. Dans le cas où le téléchargement des fichiers n'aurait pas opéré, vous trouverez les données à l'aide des liens suivants :

⬇️ Les données seront à télécharger àsont les suivantes.

    Données obtenues grâce aux GPS

wget https://datarepository.movebank.org/server/api/core/bitstreams/7f4eddd5-d98c-4001-8487-ba3020c13c0d/content -O data/PetCatsAustraliaGPS

    Caractéristiques des chats

wget https://datarepository.movebank.org/server/api/core/bitstreams/a2d483d7-f0df-4a56-a703-857d2b9cf18c/content -O data/PetCatsAustraliaCaract

    Fichier contenant toutes les informations sur les données précédentes

wget https://datarepository.movebank.org/server/api/core/bitstreams/603e5745-4ad3-4b24-9a57-02675b962e93/content -O data/PetCatsAustraliaREADME

⚠️ Dans le cas où le téléchargement des fichiers n'aurait pas opéré, vous trouverez les données à l'aide des liens suivants :

    url-dataset-australian-cats


## Sources
1. https://www.kaggle.com/datasets/sujaykapadnis/ecological-impacts-of-pet-cats?select=Pet+Cats+Australia.csv

## Description
1. Ce jeu de données a été récolté à l'aide de capteurs GPS posés sur les chats provenant des Etats-Unis, d'Angleterre, d'Australie et de Nouvelle-Zélande. Il y recence également les caractéristiques des chats telles que l'âge, le sexe et les habitudes de chasse.
