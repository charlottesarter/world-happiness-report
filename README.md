# README

Ce projet est réalisé dans le cadre de la matière <b>Visualisation de données</b> enseignée à l'Université de Technologie de Troyes.

## Lien du dataset :

- World Happiness Report : https://www.kaggle.com/datasets/unsdsn/world-happiness?select=2017.csv
- Healthy Lifestyle Cities Report 2021 : https://www.kaggle.com/datasets/prasertk/healthy-lifestyle-cities-report-2021 (à relier avec le dataset précédent)

## Introduction :

### Données:

Le jeu de données que nous avons choisi d'étudier est issu d'une enquête de référence sur l'état du bonheur dans le monde. Il comporte les données de 2015 à 2019, et classe 155 pays selon leur niveau de bonheur. Il permet d'établir une corrélation entre différents critères (liberté, corruption, cadre de vie...) et le niveau de bonheur qui en découle.

Le jeu de données comporte 13 variables: 
  
|variable                  |class     |description |
|:-------------------------|:---------|:-----------|
|country                   |character | Nom du pays |
|region                    |character | Région à laquelle le pays appartient |
|hapiness rank             |integer   | Classement du pays sur la base du score du bonheur |
|hapiness score            |double    | Un indicateur mesuré chaque année en posant aux personnes de l'échantillon la question suivante : "Comment évaluez-vous votre bonheur sur une échelle de 0 à 10 où 10 est le plus heureux" |
|lower confidence interval |double    | Intervalle de confiance inférieur du score de bonheur |
|upper confidence interval |double    | Intervalle de confiance supérieur du score de bonheur |
|economy (GPD per capita)  |double    | La mesure dans laquelle le PIB contribue au calcul du score du bonheur |
|family                    |double    | La mesure dans laquelle la famille contribue au calcul du score du bonheur |
|health (life expectancy)  |double    | La mesure dans laquelle l'espérance de vie a contribué au calcul du score du bonheur |
|freedom                   |double    | La mesure dans laquelle la liberté a contribué au calcul du score du bonheur |
|trust (governement corruption)|double| La mesure dans laquelle la perception de la corruption contribue au score de bonheur |
|generosity                |double    | La mesure dans laquelle la générosité a contribué au calcul du score de bonheur |
|dystopia residual         |double    | "Résidu" correspondant à l'écart entre le modèle théorique et la réalité, auquel on ajoute un score de dystopie (score d'un pays hypothétique moins bien classé que tous les autre) |

Ces données nous semblent pertinentes dans le cadre d'une analyse car:
- elles sont analysables dans le temps
- elles sont analysables géographiquement
- elles permettent d'établir différents facteurs de contribution au bonheur en fonction des régions du monde, des cultures...

### Plan d'analyse


