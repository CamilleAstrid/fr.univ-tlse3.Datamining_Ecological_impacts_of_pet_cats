# Etude de l'impact écologique des chats domestiques 🐈
<p align="center">
<img src="data/pictures/logo_blanc.png" alt="logo_Felinomicon" width="200" />
<p/>
 <p align="justify">
Le projet Félinomicon s'inscrit dans le cadre du Master 1 Bioinformatique et Biologie des Systèmes à l'Université de Toulouse (Paul Sabatier, Toulouse III, FRANCE), année universitaire 2024-2025. Ce dépôt contient le code, les données et les résultats associés à l'analyse bioinformatique de l'impact des chats domestiques sur la diversité écologiques.

> _"Dans les ruelles sombres, derrière les rideaux des maisons tranquilles, ils rôdent... silencieux, gracieux, insaisissables. Les chats domestiques, ces familiers de nos foyers, sont peut-être les derniers vestiges d’un lien ancien avec des forces oubliées. Et si leurs pas feutrés cachaient un déséquilibre invisible ?"_  

## Description

### Les données : une cartographie des instincts
Chaque chat est une énigme, un vecteur de traces écologiques que l'œil humain ne perçoit pas. Le croisement de ces informations forme un grimoire de comportements félins, que le projet Félinomicon s’attache à décrypter. Il commencera ainsi par une étude sur les chats australiens pour prédire :

* 🐦 le potentiel de prédation (si oui : combien en moyenne de proie par mois)
* 🛋️ le temps passé en interieur au repos
* 🏃 la distance parcourue à l'extérieure

...en fonction de variables comportementales et démographiques suivantes :
* le nombre de chats cotoyés au sein du foyer
* l'heure de sortie
* le sexe
* l'âge
* la localisation
* la stérilisation
    
### Méthodologie d’analyse : invoquer l’algorithme

À l’image d’un alchimiste manipulant des symboles anciens, nous utilisons :
- Des modèles statistiques prédictifs
- Des algorithmes d’apprentissage automatique
- Des outils de visualisation bioinformatique

Ces outils permettent de transformer des données éparses en structures de sens : cartes de risque écologique, profils types de prédateurs domestiques, zones d’impact potentielles sur la biodiversité.

### Finalité : dévoiler l’invisible

L’objectif n’est pas d’accuser, mais de comprendre. Félinomicon ambitionne de :
- Quantifier l’impact écologique des chats domestiques sur leur environnement
- Identifier les profils à fort potentiel de prédation
- Proposer des pistes d’aménagement ou de sensibilisation pour concilier bien-être animal et préservation de la faune locale

En somme, il s’agit de lever le voile sur une influence tapie dans l’ombre, souvent négligée, parfois minimisée, mais réelle.

> _"Car dans chaque miaulement nocturne, dans chaque regard perçant à travers les feuillages, se cache peut-être l’écho d’un monde que l’on pensait dompté. Le Félinomicon n’est pas un avertissement... c’est une clé."_

### Principales conclusions

Après obtention de notre modèle basé sur les chats domestiques australiens, nous avons recueilli des données sur nos petits compagnons dans le Sud Ouest de la France. Nous avons cherché à éprouver notre modèle sur un nouveau jeu de données.

:construction:

## Structure
**Dossiers et fichiers**

* `README.md`  : Fichier de présentation du projet (vous y êtes !)
* `LICENSE` : Licence d’utilisation
* `.gitignore` : liste des fichier et/ou dossier à ignorer pour le git


* **analysis/**
	*  `README.md` : Fichier de présentation des méthodes d'analyses employées et les prérequis de ces dernières
  	*  `*.png` : ensembles des images exporté de ModeleR
  	*  `*.csv` : ensemble des sorties de `ModeleR.r`
 	*  `clusteror.ipynb` : jupyter Python utilisant scipy, nottament les packages sklearn et auto-sklearn pour faire de la classification automatisé
	*  `ModeleR.R` : Script R utilisant principalement MASS afin de classifier automatiquement les chats


* **data/**
	*  `README.md` : Fichier de présentation des données
	*  `OutCatdataCaracQuanti.csv` : csv après pretraitement des caractéristiques des chats étudiés.
 	*  **French_dataset/** : ensembles des fiches récolté par l'equipe _Félinimicon_ de chats français
  		*  `README.md` : informations de l'obtention des données et leur source
    	*  `CatDataFrance.csv` : fichier d'enregistrement des données
     	*  `Felinomicon_fiche_autorisation.*` : fiche de déclaration de consentement de récupération des données

	*  **pictures/** : ensembles des images des chats de **French_dataset**

* **data.preparation/**
  	*  `README.md` : Fichier de présentation des méthodes de prétraitement et de visualisation
 	*  `DataAnalysis.*` : vignettte de prétraitement des matrices individues/variables
  	*  `Preparator.R` : Partie condensé et éxécutables de DataAnalysis pour la partie qualitatif
  	*  `PreparatorQuantitativ.R` : Partie condensé et éxécutables de DataAnalysis pour la partie quantitatif
  	*  `TrueDataAnalysisCats.*` : vignette de prétraitement et de visualisation plus poussé des matrices individu/variables
	*  **Figs/** : répertoire des figures R mises en cache


* **rapport/**
	* `Enonce.md` : enoncé du cahieer des charges demandé par R.barriot
 	* `README.md` : mise en contexte du rapport

## Outils utilisés
:construction:

## Prérequis
Langages
* ![R](https://img.shields.io/badge/R-4.4.2-darkred)
* ![Python](https://img.shields.io/badge/python-3.8-blue)

Packages (et leurs dépendances) :

![R-package](https://img.shields.io/badge/R-plotly-red) ![R-package](https://img.shields.io/badge/R-tidyverse-red) ![R-package](https://img.shields.io/badge/R-GGaly-red) ![R-package](https://img.shields.io/badge/R-stringr-red) ![R-package](https://img.shields.io/badge/R-magrittr-red) ![R-package](https://img.shields.io/badge/R-factoextra-red) ![R-package](https://img.shields.io/badge/R-Hmisc-red)

## Installation

1. Cloner ce dépôt :
   ```
   git clone https://github.com/CamilleAstrid/fr.univ-tlse3.Datamining_Ecological_impacts_of_pet_cats.git
   cd fr.univ-tlse3.Datamining_Ecological_impacts_of_pet_cats
   ```
2. Télécharger les données de l'analyse :

 ⬇️ Les données seront à télécharger à l'aide des commandes suivantes depuis ce dépôt.
  
   * Données obtenues grâce aux GPS
   ```
   wget https://datarepository.movebank.org/server/api/core/bitstreams/7f4eddd5-d98c-4001-8487-ba3020c13c0d/content -O data/PetCatsAustraliaGPS
   ```
   * Caractéristiques des chats
   ```
   wget https://datarepository.movebank.org/server/api/core/bitstreams/a2d483d7-f0df-4a56-a703-857d2b9cf18c/content -O data/PetCatsAustraliaCaract
   ```
   * Fichier contenant toutes les informations sur les données précédentes
   ```
   wget https://datarepository.movebank.org/server/api/core/bitstreams/603e5745-4ad3-4b24-9a57-02675b962e93/content -O data/PetCatsAustraliaREADME
   ```
> [!WARNING]
> Dans le cas où le téléchargement des fichiers n'aurait pas opéré, vous trouverez les données à l'aide des liens suivants :
> * [url-dataset-australian-cats](https://datarepository.movebank.org/entities/datapackage/0a9bcb2a-f031-42e7-8027-a87c09b30804)

## Reproduction des analyses
:construction:

## Licence
Ce projet et donc l'ensemble des éléments de ce répertoire est sous [licence GPL-v3](https://github.com/CamilleAstrid/fr.univ-tlse3.Datamining_Ecological_impacts_of_pet_cats/blob/main/LICENSE) (sauf cas précisé).

## Références
* [GitLab R.BARRIOT](https://gitlab.com/rbarriot/datamining.project)
* Kays R, Dunn RR, Parsons AW, Mcdonald B, Perkins T, Powers S, Shell L, McDonald JL, Cole H, Kikillus H, Woods L, Tindle H, Roetman P (2020) The small home ranges and large local ecological impacts of pet cats. Animal Conservation. Roetman P, Tindle H (2020) [doi:10.1111/acv.12563](https://zslpublications.onlinelibrary.wiley.com/doi/10.1111/acv.12563)
   * *Movebank Data*: The small home ranges and large local ecological impacts of pet cats [Australia] [doi:10.5441/001/1.289p5s77](https://datarepository.movebank.org/entities/datapackage/0a9bcb2a-f031-42e7-8027-a87c09b30804)
* OpenAI. (2024). ChatGPT (GPT-4.0) [Large language model]. https://chat.openai.com
   * Génération ou assistance de ChatGPT (OpenAI, 2024) pour la rédaction, la structuration des textes et la création d’éléments visuels.

## Auteurs

DataMining.ABC
Copyright (C) 2020  barriot

Copyright (C) 2025 CamilleAstrid AMOUROUX-J SangaraSorama

---
> [!NOTE]
> Pour toute question, veuillez contacter l'équipe par mail :
>* [Camille-Astrid Rodrigues](mailto:camilleastrid.cr@gmail.com)
>* [Jan Amouroux](mailto:jan.amouroux@univ-tlse3.fr)
>* [Célia Brahimi](mailto:celia.brahimi@univ-tlse3.fr)
>
>Si des ajustements ou des ajouts sont nécessaires, n'hésitez pas à nous le signaler !
<p/>
