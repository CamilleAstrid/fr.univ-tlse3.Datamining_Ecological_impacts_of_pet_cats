<p align="center">
<img src="../data/pictures/logo_blanc.png" alt="logo_Felinomicon" width="200" />
<p/>

# 📄 clusteror.ipynb

<details>
<summary>
<h2> 🧩 Description </h2>
</summary>
Le notebook clusteror.ipynb implémente l'étape d'analyse non supervisée du projet Félinomicon. Il est exclusivement dédié à l'exploration structurelle des données comportementales de chats domestiques par réduction dimensionnelle et clustering. L'objectif est d'identifier des regroupements naturels d'individus à partir de leurs caractéristiques individuelles (âge, sexe, environnement, statut de stérilisation) sans utiliser directement leur comportement de chasse comme variable cible.
</details>

<details>
<summary>
<h2> 🔍 Fonctionnalités principales </h2>
</summary>
	
- Prétraitement minimal : chargement d'une matrice de données pré-nettoyée et normalisée.
- Réduction de dimension :
  - ACP (Analyse en Composantes Principales)
  - MDS (MultiDimensional Scaling)
  - UMAP (Uniform Manifold Approximation and Projection)
- Clustering non supervisé :
  - Application du k-means sur l’espace réduit.
  - Optimisation du nombre de clusters par analyse du coefficient de silhouette.
- Visualisation :
  - Cartographies 2D des clusters.
  - Analyse de la qualité du clustering.
</details>

<details>
<summary>
<h2> ⚙️ Dépendances </h2>
</summary>
	
Le script requiert les librairies suivantes :
- pandas
- numpy
- scikit-learn
- auto-sklearn
</details>

<details>
<summary>
<h2> 🔽 Installation </h2>
</summary>
	
<h3> Prérequis </h3>

- Windows et Mac
  - WSL-2
  - Docker desktop
- Linux
  - Docker

<h3> Instalation des librairies python (auto-sklearn uniquement disponible Linux) </h3>

```bash
pip install -U scikit-learn
pip install auto-sklearn
```

> /!\ WARNING /!\\
> 
> Scikit-learn 1.4 nécessite python >= 3.9

<h3> Utilisation de Docker pour Windows </h3>

*Dans le cas où vous utilisez un Windows*.

Une image docker est disponible sur dockerhub. Pour le télécharger :

```bash
docker pull mfeurer/auto-sklearn:master # Download the docker image
```

Vous pouvez vérifier que l'image est téléchargée en faisant :

```bash
docker images  # Verify that the image was downloaded
```

Enfin, nous pouvons lancer le serveur pour notre jupiter : 

```bash
cd <path to >\fr.univ-tlse3.Datamining_Ecological_impacts_of_pet_cats
docker run -it -v "$(pwd):/opt/nb" -p 8888:8888 mfeurer/auto-sklearn:master /bin/bash -c "mkdir -p /opt/nb && jupyter notebook --notebook-dir=/opt/nb --ip='0.0.0.0' --port=8888 --no-browser --allow-root"
```

L'option `-v "$(pwd):/opt/nb"` permet de conserver le répertoire local de travail, ici le dépôt git.

Suite au lancement, votre console vous donne le lien http à rentrer pour le kernel de votre jupyter.

> (i) NOTE
> 
> documentation issue de [package_auto-sklearn](https://automl.github.io/auto-sklearn/master/installation.html)

</details>

<details>
<summary>
<h2> 🚀 Utilisation </h2>
</summary>
	
- Préparer un jeu de données :
	- Variables quantitatives normalisées (Z-score).
	- Sans valeurs manquantes.
- Lancer le notebook
- Exécuter les cellules pour :
	- Réduire la dimensionnalité.
	- Appliquer le clustering.
	- Visualiser les résultats.
	- Évaluer la compacité et la pertinence des regroupements.
</details>

<details>
<summary>
<h2> 📈 Données attendues </h2>
</summary>

- Format : table individus x variables.
- Variables types : âge, sexe, nombre d'heures passées à l’intérieur, nombre de proies capturées, nombre de congénères dans l’environnement immédiat.
</details>

<details>
<summary>
<h2> 🎯 Objectif du script </h2>
</summary>
	
- Vérifier l'existence éventuelle de groupes naturels de comportements.
- Explorer l'organisation comportementale latente indépendamment du statut de chasse déclaré.
</details>

<details>
<summary>
<h2> ✍️ Auteur </h2>
</summary>

<strong> AMOUROUX Jan </strong>

Contribution au projet Félinomicon – Master 1 Bioinformatique & Biologie des Systèmes – Université Toulouse III
</details>

# 📄 ModeleR.R

<details>
<summary>
<h2> 🧩 Description </h2>
</summary>

Le script ModeleR.R est utilisé dans le cadre du projet Félinomicon pour réaliser la modélisation supervisée du comportement de chasse des chats domestiques.
Il a pour objectif d'entraîner un modèle de classification, basé sur les caractéristiques individuelles des chats (âge, sexe, environnement, statut reproductif), afin de prédire leur propension à chasser.
</details>

<details>
<summary>
<h2> 🔍 Fonctionnalités principales </h2>
</summary>

- Chargement d'une matrice de données prétraitées.
- Séparation des données :
	- Jeu d’apprentissage (2/3) et jeu de test (1/3).
- Modélisation supervisée :
	- Analyse Discriminante Linéaire (LDA) pour la classification.
- Évaluation des performances :
	- Matrice de confusion.
	- Calcul du taux d'erreur et de la précision globale.
	- Analyse comparative entre classes prédictives.
</details>

<details>
<summary>
<h2> ⚙️ Dépendances </h2>
</summary>

Le script utilise les packages R suivants :
- tidyverse
- magrittr
- GGally
- plotly
- factoextra
- progress
- beepr
- uwot
- grid
- gridExtra
- stats
- docstring
- MASS
- caret

</details>

<details>
<summary>
<h2> 🔽 Installation des dépendances </h2>
</summary>

Installation dans R :
```
install.packages("caret")
install.packages("tidyverse")
install.packages("magrittr")
install.packages("GGally")
install.packages("plotly")
install.packages("factoextra")
install.packages("progress")
install.packages("beepr")
install.packages("uwot")
install.packages("grid")
install.packages("gridExtra")
install.packages("stats")
install.packages("docstring")
install.packages("MASS")
install.packages("caret") 
```
</details>

<details>
<summary>
<h2> 🚀 Utilisation </h2>
</summary>

- Préparer une matrice de données propre :
	- Variables quantitatives normalisées (Z-score).
	- Aucune valeur manquante.
	- Lancer le script dans RStudio ou en ligne de commande R.
- Exécuter :
	- La séparation du jeu de données (train/test).
	- L'entraînement du modèle LDA.
	- L'évaluation via matrice de confusion et calcul de précision.
</details>

<details>
<summary>
<h2> 📈 Données attendues </h2>
</summary>

- Format : table individus x variables.
- Variables types : âge, sexe, nombre d'heures passées à l’intérieur, nombre de proies capturées, nombre de chats voisins.
- Classe cible : comportement de chasse (Yes / No / Unknown).
</details>

<details>
<summary>
<h2> 🎯 Objectif du script </h2>
</summary>

Prédire la probabilité qu'un chat soit un chasseur actif ou non, à partir de ses caractéristiques individuelles.
</details>

<details>
<summary>
<h2> ✍️ Auteur </h2>
</summary>

<strong> RODRIGUES Camille-Astrid </strong>

collaborateur <strong> AMOUROUX Jan </strong>

Contribution au projet Félinomicon – Master 1 Bioinformatique & Biologie des Systèmes – Université Toulouse III
</details>

