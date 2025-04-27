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
* `.gitignore` : Liste des fichiers et/ou dossiers à ignorer pour le git


* **analysis/**
	*  `README.md` : Fichier de présentation des méthodes d'analyses employées et les prérequis de ces dernières
  	*  `*.png` : Ensemble des images exportées de ModeleR
  	*  `*.csv` : Ensemble des sorties de `ModeleR.r`
 	*  `clusteror.ipynb` : Jupyter Python utilisant *scipy*, notamment les packages *sklearn* et *auto-sklearn* pour faire de la classification automatisée
	*  `ModeleR.R` : Script R utilisant principalement MASS afin de classifier automatiquement les chats


* **data/**
	*  `README.md` : Fichier de présentation des données
	*  `OutCatdataCaracQuanti.csv` : Fichier csv après prétraitement des caractéristiques des chats étudiés
 	*  **French_dataset/** : Ensemble des fiches récoltées par l'équipe _Félinomicon_ de chats français
  		*  `README.md` : Informations sur l'obtention des données et de leur source
    	*  `CatDataFrance.csv` : Fichier d'enregistrement des données
     	*  `Felinomicon_fiche_autorisation.*` : Fiche de déclaration de consentement de récupération des données

	*  **pictures/** : Ensemble des images des chats de **French_dataset**

* **data.preparation/**
  	*  `README.md` : Fichier de présentation des méthodes de prétraitement et de visualisation
 	*  `DataAnalysis.*` : vignettte de prétraitement des matrices individues/variables
  	*  `Preparator.R` : Partie condensé et éxécutables de DataAnalysis pour la partie qualitatif
  	*  `PreparatorQuantitativ.R` : Partie condensé et éxécutables de DataAnalysis pour la partie quantitatif
  	*  `TrueDataAnalysisCats.*` : Vignette de prétraitement et de visualisation plus avancées des matrices individu/variables
	*  **Figs/** : Répertoire des figures R


* **rapport/**
	* `Enonce.md` : Enoncé du cahier des charges requis
 	* `README.md` : Mise en contexte du rapport

## Outils utilisés
* Docker ou Docker-desktop
* RStudio

## Prérequis
Langages
* ![R](https://img.shields.io/badge/R-4.4.2+-darkred)
* ![Python](https://img.shields.io/badge/python-3.8+-blue)

Packages (et leurs dépendances) :

![R-package](https://img.shields.io/badge/R-tidyverse-red) ![R-package](https://img.shields.io/badge/R-ggally-red) ![R-package](https://img.shields.io/badge/R-shiny-red) ![R-package](https://img.shields.io/badge/R-plotly-red) ![R-package](https://img.shields.io/badge/R-knitr-red) ![R-package](https://img.shields.io/badge/R-magrittr-red) ![R-package](https://img.shields.io/badge/R-stringr-red) ![R-package](https://img.shields.io/badge/R-kableextra-red) ![R-package](https://img.shields.io/badge/R-cluster-red) ![R-package](https://img.shields.io/badge/R-gridextra-red)

![R-package](https://img.shields.io/badge/R-factoextra-red) ![R-package](https://img.shields.io/badge/R-Hmisc-red) ![R-package](https://img.shields.io/badge/R-gridExtra-red) ![R-package](https://img.shields.io/badge/R-grid-red) ![R-package](https://img.shields.io/badge/R-uwot-red) ![R-package](https://img.shields.io/badge/R-progress-red) ![R-package](https://img.shields.io/badge/R-stats-red)


![Python-package](https://img.shields.io/badge/Python-numpy-lightblue) ![Python-package](https://img.shields.io/badge/Python-pandas-lightblue) ![Python-package](https://img.shields.io/badge/Python-scipy-lightblue) ![Python-package](https://img.shields.io/badge/Python-scikit_learn-lightblue) ![Python-package](https://img.shields.io/badge/Python-matplotlib-lightblue) ![Python-package](https://img.shields.io/badge/Python-plotly-lightblue) ![Python-package](https://img.shields.io/badge/Python-ipykernel-lightblue) ![Python-package](https://img.shields.io/badge/Python-nb_conda_kernels-lightblue) ![Python-package](https://img.shields.io/badge/Python-jupyterlab-lightblue) ![Python-package](https://img.shields.io/badge/Python-auto_sklearn-lightblue)


## Installation

1. Cloner ce dépôt :
   ```
   git clone https://github.com/CamilleAstrid/fr.univ-tlse3.Datamining_Ecological_impacts_of_pet_cats.git
   cd fr.univ-tlse3.Datamining_Ecological_impacts_of_pet_cats
   ```
   
2. Télécharger les données de l'analyse :

 ⬇️ Les données seront à télécharger à l'aide des commandes suivantes depuis ce dépôt.
  
   * Données obtenues grâce aux GPS
   ```bash
   wget https://datarepository.movebank.org/server/api/core/bitstreams/7f4eddd5-d98c-4001-8487-ba3020c13c0d/content -O data/PetCatsAustraliaGPS
   ```
   * Caractéristiques des chats
   ```bash
   wget https://datarepository.movebank.org/server/api/core/bitstreams/a2d483d7-f0df-4a56-a703-857d2b9cf18c/content -O data/PetCatsAustraliaCaract
   ```
   * Fichier contenant toutes les informations sur les données précédentes
   ```bash
   wget https://datarepository.movebank.org/server/api/core/bitstreams/603e5745-4ad3-4b24-9a57-02675b962e93/content -O data/PetCatsAustraliaREADME
   ```

> [!WARNING]
> Dans le cas où le téléchargement des fichiers n'aurait pas opéré, vous trouverez les données à l'aide du lien suivant :
> * [dataset-australian-cats](https://datarepository.movebank.org/entities/datapackage/0a9bcb2a-f031-42e7-8027-a87c09b30804)

3. Installation d'un conteneur Docker

> [!CAUTION]
> Nécessaire si vous ne possédez pas de machine Linux !

Une image docker est disponible sur dockerhub. Pour le télécharger : 

```bash
docker pull mfeurer/auto-sklearn:master # Download the docker image
```

4. Téléchargement environnement mamba

> [!TIP]
> L'installation de l'environnement suivant n'est pas nécessaire. Cependant, la présence de tous les prérequis sont indispensables sur la machine. Leur nombre étant important, nous avons mis à disposition la ligne de commande suivante afin de télécharger l'ensemble des packages requis.

```bash
mamba create -n Felinomicon r-base=4.4.2 r-tidyverse r-ggally  r-shiny r-plotly r-knitr r-magrittr r-stringr r-kableextra r-cluster r-gridextra r-factoextra r-Hmisc r-gridExtra r-grid r-uwot r-progress r-stats python=3.8 numpy pandas scipy scikit-learn matplotlib plotly ipykernel nb_conda_kernels jupyterlab auto-sklearn 

mamba activate Felinomicon # Activation of the environment
```

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
<p/>

> [!NOTE]
> Pour toute question, veuillez contacter l'équipe par mail :
>* [Camille-Astrid Rodrigues](mailto:camilleastrid.cr@gmail.com)
>* [Jan Amouroux](mailto:jan.amouroux@univ-tlse3.fr)
>* [Célia Brahimi](mailto:celia.brahimi@univ-tlse3.fr)
>
>Si des ajustements ou des ajouts sont nécessaires, n'hésitez pas à nous le signaler !

---

> [!WARNING]
> La section suivante peut effrayer certains curieux qui ne sont pas prêt à s'ouvrir à la vérité.
 
<p align="center"> <strong> Les chats d'Ulthar </strong> <p/>

> _"On dit qu’à Ulthar, qui se trouve au-delà du fleuve Skaï, nul ne peut tuer un chat; et, en vérité, je veux bien le croire, comme j’observe celui qui est couché là, ronronnant devant le feu. [...]_
>
> _À Ulthar, avant même que les autorités n’interdisent le meurtre des chats, demeuraient un vieux paysan et sa femme qui prenaient plaisir à piéger et tuer les chats de leurs voisins. Pour quelles raisons ils le faisaient, je l’ignore [...]. Mais qu’importe les raisons, ce vieil homme et sa femme prenaient plaisir à piéger et tuer tous les chats qui approchaient de leur demeure [...]. En vérité, beaucoup de propriétaires de chats détestaient ces vieillards, mais les craignaient plus encore ; et au lieu de les réprimander comme les violents assassins qu’ils étaient, ils prenaient plutôt soin à ce que leurs animaux de compagnie ou greffiers chéris restent éloignés de ce lointain taudis sous les arbres sombres. Et quand, inévitablement, un chat venait à manquer, et que des sons affreux étaient entendus après la tombée du jour, celui à qui on avait enlevé son animal familier pleurait, impuissant ; ou se consolait en remerciant le Destin que ce n’était pas un de ses enfants qui avait disparu. Car les gens d’Ulthar étaient simples, et ignoraient tout de la première arrivée des chats._
>
> _Un jour, une caravane d’étranges vagabonds du Sud entra par les rues étroites et pavées de la ville d’Ulthar. Sombres étaient ces voyageurs, et bien différents de ces autres nomades qui passaient le village deux fois l’an. [...] Nul ne savait de quelles contrées ils venaient ; mais ils avaient été vus s’adonnant à d’étranges oraisons, et sur les flancs de leurs roulottes étaient peintes d’étranges figures à corps humains et têtes de chats, de faucons, de béliers et de lions. Et le chef de cette caravane portait une coiffe ornée de deux cornes entre lesquelles était disposé un curieux disque._
>
> _Il y avait, dans ce convoi singulier, un petit garçon qui n’avait ni père ni mère, juste un petit chat noir à chérir. La peste ne l’avait guère épargné, pourtant elle lui avait laissé cette petite chose touffue pour atténuer sa peine ; et quand on est si jeune, on peut trouver un grand apaisement dans les espiègleries d’un chaton noir. [...]_
>
> _Au troisième matin du séjour des voyageurs à Ulthar, Ménès ne retrouvait pas son chat ; et, alors qu’il sanglotait sur la place du marché, certain villageois lui racontèrent les rumeurs autour du vieil homme et de sa femme, et des bruits entendus lors de la nuit. Ainsi, lorsqu’il entendit ces choses, ses sanglots furent remplacés par la méditation, puis par des prières. Il allongea ses bras vers le soleil et pria dans une langue qu’aucun villageois ne pouvait comprendre ; et même, les villageois n’essayèrent pas de comprendre, tant leur attention était portée sur le ciel et les formes fantasques que les nuages épousaient. C’était très particulier, mais alors que le jeune homme relâchait sa requête, il semblait se former au-dessus de ténébreuses et nébuleuses silhouettes exotiques ; de créatures hybrides couronnées de disques ornés de cornes. La Nature regorge de telles illusions qui impressionnent les imaginatifs._
>
> _Cette nuit-là, les vagabonds quittèrent Ulthar, et on ne les y revit jamais. Les villageois s’inquiétèrent alors en découvrant que, dans tout le village, on ne trouvait plus un chat. [...] Toutefois, personne n’alla se plaindre du sinistre couple ; même lorsque le jeune Atal, le fils de l’aubergiste, jura qu’il avait vu au crépuscule les chats d’Ulthar sur ce champ enclavé sous les arbres, faisant la ronde doucement et solennellement autour de la masure, en rangs par deux, comme s’ils célébraient un rite animal inconnu. [...]_
>
> _Alors Ulthar s’endormit dans une colère vaine ; et quand les gens se réveillèrent à l’aube — surprise ! tous les chats étaient de retour dans leur foyer ! [...] Les chats semblaient gras et doux, et ils ronronnaient de contentement. [...] ils étaient tous d’accord sur une chose : le refus des chats de manger leur mou et de boire leur soucoupe de lait était extrêmement curieux. Et pendant deux jours, les chats paresseux d’Ulthar ne touchèrent aucune nourriture, ils se prélassaient juste à la chaleur du feu ou du soleil._
>
> _Il fallut attendre une semaine complète avant que les villageois ne remarquent qu’aucune lumière n’émanait des fenêtres de la maison sous les arbres au crépuscule. Ensuite, le frêle Nith fit remarquer que personne n’avait vu le vieil homme et sa femme depuis la nuit où les chats étaient partis. La semaine suivante, le bourgmestre décida de surmonter ses peurs. Il considérait qu’enquêter sur cet étrange silence persistant était un devoir afférent à sa charge, mais par précaution, il se fit accompagner de Shang le forgeron et de Thul le tailleur de pierre, en qualité de témoins. Et, après avoir fracassé la porte branlante, ils ne trouvèrent que ceci : deux squelettes humains proprement récurés sur le sol de terre, et un nombre impressionnant de scarabées rampant dans les coins sombres._
>
> _Et finalement, les autorités passèrent cette loi remarquable qui est racontée par les marchands à Hatheg et mentionnée par les voyageurs à Nir ; à savoir, qu’à Ulthar, nul ne peut tuer un chat._

<p align="right">
H. P. Lovecraft
<p/>
