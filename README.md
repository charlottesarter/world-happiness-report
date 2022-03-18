# README

Projet réalisé dans le cadre de la matière Visualisation de données enseignée à l'Université de Technologie de Troyes.

## Introduction :

### Données:

Ce jeu de données concerne des données sur les publicités diffusées lors du superbowl lors de différentes années entre 2000 et 2020. Il concerne des vidéos Youtube.
Il comporte 25 variables: 
  
  |variable                  |class     |description |
|:-------------------------|:---------|:-----------|
|year                      |double    | année de la vidéo |
|brand                     |character | la marque faisant sa publicité |
|superbowl_ads_dot_com_url |character | url renvoyant vers le site du superbowl et la publicité en question |
|youtube_url               |character | l'url de la vidéo |
|funny                     |logical   | booléen indiquant si la publicité est drôle |
|show_product_quickly      |logical   | booléen indiquant si le spectateur peut cerner l'objet de la publicité rapidement ou non |
|patriotic                 |logical   | booléen indiquant si la pub est patriote |
|celebrity                 |logical   | booléen indiquant si la pub contient une célébrité |
|danger                    |logical   | booléen indiquant si la pub contient du "danger" (= une situation dangereuse) |
|animals                   |logical   | booléen indiquant si la pub contient des animaux |
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
