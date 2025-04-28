<p align="center">
<img src="../data/pictures/logo_blanc.png" alt="logo_Felinomicon" width="200" />
<p/>

Scripts et/ou workflows utilisés pour la fouille de données à partir de la matrice *individus-variables*.

## Instalation des librairies python (auto-sklearn uniquement disponible Linux) : 

```bash
pip install -U scikit-learn
pip install auto-sklearn
```

> [!WARNING]
> Scikit-learn 1.4 nécessite python >= 3.9

## Utilisation de Docker pour Windows

Dans le cas où vous utilisez un Windows  .

### Prérequis : 

* Windows et Mac
  * WSL-2
  * Docker desktop
* Linux
  * Docker

### Installation : (doc issue de [package_auto-sklearn](https://automl.github.io/auto-sklearn/master/installation.html))

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
