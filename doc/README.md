# SneakBoutique - Eshop de Sneakers

## Table des Matières

- [Introduction](#introduction)
- [Fonctionnalités](#fonctionnalités)
- [Installation](#installation)
- [Utilisation](#utilisation)
- [Dépendances](#dépendances)
- [Configuration](#configuration)
- [Exemples](#exemples)

## Introduction

**SneakBoutique** est une application web et mobile développée avec Flutter pour offrir une expérience d'achat de sneakers en ligne. L'application propose deux types de comptes : un compte administrateur permettant de gérer l'inventaire et un compte utilisateur pour parcourir, liker, et ajouter des produits au panier.

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

## Installation

Pour installer l'application sur votre système, suivez ces étapes :

1. Assurez-vous d'avoir Flutter installé sur votre machine.
2. Clonez le dépôt Git du projet :
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

## Dépendances

Ce projet dépend de plusieurs paquets Flutter, dont :

- `flutter_camera` : Pour permettre à l'administrateur de prendre des photos des sneakers.
- `http` : Pour la communication réseau.
- `provider` : Pour la gestion d'état.

## Exemples

- On peut mettre des screens de l'app ?
