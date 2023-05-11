# Puissance 4

Puissance 4 est un jeu classique de stratégie à deux joueurs où le but est d'aligner quatre jetons de la même couleur en ligne, colonne ou diagonale. Ce jeu de Puissance 4 est implémenté en Ruby et peut être joué sur le terminal. Les joueurs sont représentés par les jetons 'O' et '@'. 

## Installation

1. Clonez ou téléchargez le repository.
2. Assurez-vous d'avoir Ruby installé sur votre système.
3. Exécutez la commande `bundle install` pour installer les dépendances nécessaires.

## Utilisation

Le jeu peut être lancé avec la commande suivante:

```
ruby puissance4_server.rb
```

Les joueurs doivent alternativement choisir une colonne (1 à 7) où placer leur jeton en entrant le numéro correspondant dans la console. Le jeu affichera le tableau après chaque coup et annoncera le gagnant si l'un des joueurs aligne quatre jetons. 

Pour jouer en ligne avec un autre joueur sur le même réseau, vous devez exécuter le serveur avec l'option `--online` et spécifier le port à utiliser:

```
ruby puissance4_server.rb --online [port]
```

L'autre joueur doit exécuter le client avec l'adresse IP de l'hôte du serveur et le port utilisé par le serveur:

```
ruby puissance4_client.rb [adresse_ip] [port]
```

## Sécurité

Le jeu de Puissance 4 sur terminal ne nécessite pas de mesures de sécurité particulières. Cependant, lorsque vous jouez en ligne, assurez-vous d'utiliser un réseau sécurisé et de ne pas divulguer vos informations personnelles.
