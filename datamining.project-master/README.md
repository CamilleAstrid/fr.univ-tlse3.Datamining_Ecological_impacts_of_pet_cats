# Introduction

Ce projet GitLab va servir de point de départ pour la remise du projet de fouille de données. Il s'agit depuis votre compte GitLab de créer un projet à partir de ce dépôt pour récupérer la structure de base et au fur et à mesure y ajouter les scripts de préparation des données pour obtenir matrice individus-variables qui servira pour la prise en main, et ensuite l'analyse, et enfin le rapport.

Il y a donc quelques répertoires qu'il vous faudra utiliser et compléter (et **nettoyer pour le rendu final**) :

- `data.preparation`: il va contenir un sous-répertoire avec les scripts (R, python, bash, ...) permettant, à partir des fichiers de données fournis, d'obtenir la matrice (individus-variables ou individus-variables+classe) pour l'analyse de fouille de données. Il doit contenir aussi la documentation utilisateur qui indiquera comment configurer et utiliser les scripts pour obtenir la matrice.

- `analysis`: ce répertoire contiendra les scripts (R, python, ...) et/ou workflows (Knime, ...) ayant servi à l'analyse de la matrice de données et l'évaluation des performances.

- `rapport`: ce répertoire contiendra le rapport qui sera au format Markdown. Ainsi, il sera possible de le visualiser et de l'éditer directement sur GitLab ou bien localement tout en permettant un suivi des modifications et un travail collaboratif.

- `data`: ce répertoire contient les données de départ (brutes) permettant de réaliser le projet. La **provenance des données** doit être indiquée. Pour le projet ABC, **il ne faut pas** concrètement les mettre sur GitLab (ni autre site accessible) car je les ai. En paramétrant git, cela permet de les avoir en local, avec les mêmes chemins et les mêmes noms, sans avoir à les mettre sur GitLab, et ainsi, les scripts de préparation des données devraient fonctionner plus facilement.

# Calendrier 
## 2024-25

- **Rendu 1. 21 mars:** Groupes de projet (2 personnes par groupe)
  - **envoyer un mail à RB avec le lien vers votre projet** GitLab. Attention à ce que votre projet soit accessible par lui (ajouter l'utilisateur **@rbarriot** aux membres du projet avec le rôle *developper* ou *maintainer* s'il n'est pas public).
- **Phase A. Elaboration du projet : recherche d'un jeu de données dans un domaine relatif à la biologie (au sens très large : santé-médecine-agro-environnement-écologie) et définition des objectifs**
- **Rendu 2. 4 avril:** Jeu de données initial et objectifs détaillés du projet
  - Mise à jour de la page d'accueil de votre gitlab avec la description du jeu de données qui va être utilisé, le lien vers les données, et une section **Objectifs** (sur la page d'accueil) décrivant succinctement l'analyse qui va être effectuée
- **Phase B. Exploration et analyse des données, sélection des variables pertinentes et constitution de la matrice *individus-variables* pour la fouille**
- **Rendu 3. 18 avril:** Matrice de données *individus-variables* à fournir avec les scripts et la documentation utilisateur pour l'obtenir 
  - Mise à jour du projet GitLab avec les données de départ (sauf si elles sont trop volumineuses) ainsi que la matrice dans le répertoire data et les scripts pour obtenir la matrice à partir des données dans le répertoire [data.preparation](./data.preparation)). Il faudra 
- **Phase C. Mise en oeuvre de la fouille et obtention des résultats et de leur évaluation sur la matrice *individus-variables***
- **Rendu 4. 25 avril:** Mise en forme et remise
  - Mise à jour du projet GitLab 
    - Page d'accueil : étude réalisée et principaux résultats obtenus
    - Répertoire [analysis](./analysis) avec les analyes effectuées (scripts R, python ou worklfow Knime, ...) mis en oeuvre pour obtenir les résultats et conclusions
    - Répertoire [rapport](./rapport) 
    - **Fin du projet :** **dépôser le rapport converti au format PDF sur [moodle](https://moodle.univ-tlse3.fr/mod/assign/view.php?id=494193)** et **envoyer un mail à RB** qui récupérera les dépôts de chaque projet pour évaluation.

# Première étape : compte GitLab et clonage du projet

La première étape pour vous va donc être de créer un compte GitLab si vous n'en avez pas. Et ensuite, de cloner ce projet et d'inviter l'autre membre de votre groupe pour le projet afin d'avoir un seul et même projet par groupe.

Une fois que vous aurez un compte, pour importer ce projet dans votre compte :

- Faire *New project*
- Dans l'onglet *Import project* choisir *Repo by URL*
- Mettre l'URL : https://gitlab.com/rbarriot/datamining.project.git et renseigner le *Project name*

GitLab va copier la totalité du projet et vous pourrez travailler sur votre propre copie.

# Remarques sur GitLab

- L'idée est de vous forcer à **utiliser git** pour, si ce n'est pas déjà le cas, vous familiariser avec le **suivi de versions** de scripts et autres. C'est particulièrement important lorsqu'on a une version qui fonctionne et que l'on cherche à modifier. Et, c'est une **compétence demandée** dans le privé comme dans le public.
- En plus, cela va me permettre de suivre le niveau d'activité de votre projet et des contributions.
- Il est donc important pour chacun de vous d'utiliser git, GitLab et leurs fonctionnalités. Il ne s'agit surtout pas de cloner une fois le projet au début, puis de travailler uniquement sur votre copie, pour déposer toutes les modifications à la fin en une fois. GitLab devrait **vous permettre de vous répartir certaines tâches** puis déposer et partager vos résultats avec l'autre membre de votre groupe. De même, pour la rédaction de la doc utilisateur et du rapport. Cela devrait vous permettre de vous répartir des parties à rédiger pour ensuite fusionner les documents produits chacun de votre côté.

# Liens

- Projet systèmes ABC : https://gitlab.com/rbarriot/datamining.abc
- Jeux de données hébergées sur 
  - kaggle : https://www.kaggle.com/datasets
  - UC Irvine Machine Learning Repository : http://archive.ics.uci.edu/
  - Wikipedia : https://en.wikipedia.org/wiki/List_of_datasets_for_machine-learning_research#Biological_data
- Mini-tutoriel git : https://gitlab.com/rbarriot/guides/-/tree/master/git