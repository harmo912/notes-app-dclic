# Notes App

Application mobile de gestion de notes développée avec Flutter dans le cadre du projet final du module Développement Mobile niveau intermédiaire, formation D-CLIC de l'OIF.

## Présentation

L'application permet à un utilisateur de se connecter via un écran de login sécurisé, puis de gérer ses notes personnelles (ajout, modification, suppression) avec un stockage local persistant grâce à SQLite. L'objectif était de mettre en pratique les widgets Flutter, la connexion à une base de données locale et les bonnes pratiques d'interface utilisateur vues pendant la formation.

## Identifiants de connexion

Un compte est créé automatiquement au premier lancement de l'application :

- Nom d'utilisateur : `admin`
- Mot de passe : `admin123`

## Fonctionnalités

- Écran de connexion avec vérification des identifiants et message d'erreur en cas d'échec
- Écran principal listant toutes les notes enregistrées, avec chargement automatique depuis la base
- Ajout d'une nouvelle note (titre et contenu)
- Modification d'une note existante en cliquant dessus
- Suppression d'une note avec demande de confirmation
- Stockage local des notes et du compte utilisateur via SQLite (sqflite)
- Gestion des erreurs à chaque opération sur la base de données
- Interface avec animations légères sur la liste et transitions entre écrans

## Structure du projet

lib/
main.dart Point d'entrée de l'application
models/
user.dart Modèle de données utilisateur
note.dart Modèle de données note
database/
database_helper.dart Création de la base SQLite et opérations CRUD
screens/
login_screen.dart Écran de connexion
notes_list_screen.dart Écran principal, liste des notes
note_edit_screen.dart Écran d'ajout et de modification d'une note

## Choix de conception

La base de données est gérée par une classe unique (`DatabaseHelper`) en singleton, ce qui évite d'ouvrir plusieurs connexions à la base pendant l'exécution de l'app. Deux tables sont créées à l'initialisation : `users` (avec un compte admin inséré automatiquement) et `notes`.

L'écran d'ajout et l'écran de modification de note partagent le même fichier (`note_edit_screen.dart`), le composant détecte si une note est passée en paramètre pour savoir s'il doit créer ou mettre à jour un enregistrement. Ça évite de dupliquer l'interface et la logique entre les deux cas.

Côté visuel, j'ai choisi une palette violette (dégradé sur l'écran de connexion, couleur d'accent sur le reste de l'app) plutôt que le thème par défaut de Flutter, avec des cartes arrondies et une légère animation d'apparition sur la liste des notes pour un rendu plus abouti.

## Installation et utilisation

Prérequis : avoir Flutter installé sur la machine (`flutter --version` pour vérifier).

1. Cloner le dépôt :

git clone https://github.com/harmo912/notes-app-dclic.git
cd notes-app-dclic


2. Installer les dépendances :

flutter pub get


3. Lancer l'application sur un appareil ou un émulateur Android connecté :

flutter run


L'application a été développée et testée sur Android (téléphone physique). Le stockage SQLite est natif sur mobile, l'app fonctionne directement sans configuration supplémentaire.

## Wireframe

La maquette de conception (wireframe) des 3 écrans principaux est disponible ici :
https://www.figma.com/design/XrwNT2rpbiv6gAemvKOsO7/Notes-App---Wireframe

## Auteur

Harmonic Hounleba (harmo912)
Projet réalisé dans le cadre de la formation D-CLIC, module Développement Mobile, niveau intermédiaire.