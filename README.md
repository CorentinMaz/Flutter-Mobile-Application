# SneakBoutique - Eshop de Sneakers

## Table des Matières

- [Introduction](#introduction)
- [Installation](#installation)
- [Utilisation](#utilisation)
- [Architecture](#architecture)
- [Fonctionnalités](#fonctionnalités)
- [Dépendances](#dépendances)

## Introduction

**SneakBoutique** est une application web et mobile développée avec Flutter pour offrir une expérience d'achat de sneakers en ligne. L'application propose deux types de comptes : un compte administrateur permettant de gérer l'inventaire et un compte utilisateur pour parcourir, liker, et ajouter des produits au panier.

## Installation

Pour installer l'application sur votre système, suivez ces étapes :

1. Assurez-vous d'avoir Flutter installé sur votre machine.
2. Clonez le dépôt Git du projet :
   ```
    git@github.com:CorentinMaz/Flutter-Mobile-Application.git
   ```
3. Naviguez dans le dossier du projet cloné et exécutez :

   ```
   flutter pub get
   ```

4. Lancez l'application sur un simulateur ou un appareil physique :

   ```
   flutter run
   ```

## Utilisation

Après l'installation, lancez l'application. Vous pouvez vous connecter en tant qu'administrateur ou utilisateur selon le type de compte que vous possédez.

## Configuration

### Dossier Packages

Le dossier **packages** contient les classes de repository. Ces classes sont responsables de la gestion des données. Elles récupèrent les données de différentes sources, gèrent le cache, et fournissent une interface de données unifiée au reste de l'application.

Un exemple de ces classes est le shoes_repository, qui gère les données relatives aux chaussures. Il dépend de plusieurs paquets Flutter, dont cloud_firestore pour la récupération des données à partir de Firestore.

- Le dossier **lib/src/entities** contient les entités de l'application. Les entités sont des objets qui représentent des concepts de l'application, comme une chaussure ou un utilisateur. Elles contiennent les données et la logique métier associées à ces concepts.

- Le dossier **lib/src/models** contient les modèles de données. Les modèles sont des objets qui représentent la structure des données que l'application utilise. Ils sont généralement utilisés pour mapper les données entre l'application et la base de données ou l'API.

Chaque dossier de fonctionnalité contient le code spécifique à cette fonctionnalité, y compris les widgets, les blocs, et les modèles.

### Dossier Lib

Le dossier **lib** est le cœur de l'application Flutter. Il contient le fichier Dart principal (main.dart), qui est le point d'entrée de l'application. Ce dossier comprend également tous les fichiers de code Dart qui définissent les widgets, les services et les utilitaires de l'application.

Dans le dossier lib, vous trouverez un sous-dossier screens qui contient les fichiers de code pour chaque écran de l'application. Chaque écran a son propre sous-dossier qui contient tous les fichiers nécessaires pour cet écran. Voici une description détaillée de chaque sous-dossier :

- auth: Ce dossier contient les fichiers pour l'écran d'authentification. Il comprend le code pour l'écran de bienvenue et le bloc pour la connexion. Le bloc SignInBloc gère l'état de la connexion.

- home: Ce dossier contient les fichiers pour l'écran d'accueil. Il comprend le code pour l'écran d'accueil et le bloc pour obtenir les chaussures. Le bloc GetShoesBloc gère l'état de la récupération des chaussures à partir du FirebaseShoesRepo.

- profil: Ce dossier contiendrait les fichiers pour l'écran de profil. Il comprendrait le code pour l'écran de profil et le bloc pour gérer les informations de profil de l'utilisateur.

Les dossiers blocs et screens jouent un rôle crucial dans l'organisation du code et la gestion de l'état. Voici une description de ces dossiers :

- **screens** : Ce dossier contient les fichiers pour chaque écran de l'application. Chaque écran a son propre sous-dossier qui contient tous les fichiers nécessaires pour cet écran. Par exemple, auth, home, profil sont des sous-dossiers qui contiennent le code pour l'écran d'authentification, l'écran d'accueil et l'écran de profil respectivement. Chaque sous-dossier contient généralement un fichier screen_name_screen.dart qui est le widget principal pour l'écran.

- **blocs** : Ce dossier contient les fichiers pour la gestion de l'état de chaque écran. Pour chaque écran, il y a un sous-dossier correspondant dans le dossier blocs. Chaque sous-dossier contient généralement les fichiers suivants :

  - **screen_name_bloc.dart** : C'est le bloc qui gère l'état de l'écran. Il écoute les événements de l'écran et met à jour l'état en conséquence.
  - **screen_name_event.dart** : Ce fichier définit les différents événements que le bloc de l'écran peut traiter. Ces événements déclenchent généralement des actions telles que la récupération de données ou la mise à jour de l'état de l'interface utilisateur.
  - **screen_name_state.dart** : Ce fichier définit les différents états que le bloc de l'écran peut avoir. Ces états représentent généralement les différentes conditions de l'interface utilisateur, comme le chargement, le succès, l'échec, etc.

En outre, chaque écran utilise généralement un repository pour gérer la communication avec le backend. Ces fichiers **screen_name_repository.dart** sont situés dans un dossier séparé appelé repositories.

## Fonctionnalités

### Compte Administrateur

- **Gestion de l'inventaire** : Ajoutez, modifiez et supprimez des chaussures avec des détails tels que la taille, le prix, le nom et la photo.
- **Gestion des photos** : Utilisez la galerie ou l'appareil photo du téléphone pour ajouter ou modifier les photos des chaussures.

### Compte Utilisateur Normal

- **Navigation dans le catalogue** : Accédez à la liste des chaussures disponibles, filtrez par prix, taille ou catégorie, et utilisez la barre de recherche pour trouver des chaussures spécifiques.
- **Interaction** : Likez vos chaussures préférées pour les mettre en avant dans la liste.
- **Gestion du panier** : Ajoutez des chaussures à votre panier et visualisez-les dans une page dédiée. Validez votre panier pour simuler une commande.

### Fonctionnalités Communes

- **Profil utilisateur** : Consultez et modifiez vos informations personnelles et consultez l'historique de vos commandes.

## Dépendances

Ce projet dépend de plusieurs paquets Flutter, dont :

- `flutter_camera` : Pour permettre à l'administrateur de prendre des photos des sneakers.
- `http` : Pour la communication réseau.
- `provider` : Pour la gestion d'état.
- `cloud_firestore` : Pour utiliser la base de données Cloud Firestore de Firebase.
- `cloud_firestore_platform_interface` : Pour toutes les implémentations de la plateforme Cloud Firestore.
- `cloud_firestore_web` : Pour Cloud Firestore.
- `collection` : Pour travailler avec des collections, comme les listes et les ensembles.
- `fake_async` : Pour tester le code asynchrone.
- `firebase_auth` : Pour utiliser l'authentification Firebase.
- `firebase_auth_platform_interface` : Pour toutes les implémentations de la plateforme Firebase Auth.
- `firebase_auth_web` : Pour Firebase Auth.
- `firebase_core` : Pour utiliser les fonctionnalités de base de Firebase.
- `firebase_core_platform_interface` : Pour toutes les implémentations de la plateforme Firebase Core.
- `firebase_core_web` (pubspec.lock) : Pour Firebase Core.
- `cupertino_icons` (pubspec.lock) : Un ensemble d'icônes de style Cupertino pour Flutter.
- `equatable` (pubspec.lock) : Pour simplifier l'égalité entre les objets.
