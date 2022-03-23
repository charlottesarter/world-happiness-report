# README

Ce projet est réalisé dans le cadre de la matière <b>Visualisation de données</b> enseignée à l'Université de Technologie de Troyes.

## Idées :

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
|use_sex                   |logical   | booléen indiquant si la pub contient des connotations sexuelles |
|id                        |character | ID de la vidéo (chaine de caractère) |
|kind                      |character | type de contenu (valeur: "youtube#video" pour tout le jeu de données) |
|etag                      |character | Youtube etag |
|view_count                |integer   | nombre de vues |
|like_count                |integer   | nombre de likes |
|dislike_count             |integer   | nombre de dislikes |
|favorite_count            |integer   | nombre de favoris (vaut zéro pour chaque colonne, inutile) |
|comment_count             |integer   | nombre de commentaires |
|published_at              |character | date de publication de la vidéo |
|title                     |character | titre |
|description               |character | description de la vidéo |
|thumbnail                 |character | url de la miniature |
|channel_title             |character | titre de la chaîne |
|category_id               |character | id de la catégorie Youtube correspondante |

Et 247 enregistrements.

Ces données nous semblent pertinentes dans le cadre d'une analyse car permettraient potentiellement de mettre en lumière différentes corrélations (qu'est-ce qui fonctionne le mieux dans les publicités) et des tendances car s'étalent sur plusieurs années. Elles sont en outre de nature à faciliter l'analyse (via des booléens, des entiers et des catégories par exemple).

### Plan d'analyse

- Quelles sont les caractéristiques (parmi les variables funny, show_product_quickly, patriotic...) qui plaisent le plus? (= celles qui ont le plus de vues et de like)
- Les publicités les plus courtes sont-elles le plus efficaces? (récupérer la durée des vidéos via leur ID et l'api Google)
- Quelles sont les catégories qui fonctionnent le mieux? (nom des catégories à récupérer via leur category_id)
 --> Etudier les statistiques des différentes catégories du jeu de données (nombre de vues moyen, durée moyenne, caractéristiques présentes...)
- Etablir un ratio likes/dislikes selon les catégories/les caractéristiques d'une vidéo
- Essayer de récupérer, si possible, le watchtime moyen des vidéos et regarder si un attribut "show_product_quickly" à true incite le spectateur à rester plus longtemps sur la vidéo
- Voir s'il existe éventuellement une corrélation entre la présence de danger dans la pub (connotation negative pour le spectateur) et le nombre de dislikes sur la vidéo
- Etudier la corrélation entre la présence de différentes caractéristiques dans une publicité (patriotisme, présence d'une célébrité...) et le nombre de réactions total (like, dislikes, commentaires) --> qu'est-ce qui fait réagir les gens le plus? Une publicité efficace est une publicité qui marque
