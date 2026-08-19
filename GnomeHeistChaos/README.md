# 🎮 Gnome Heist Chaos

**Un jeu coopératif/versus chaotique où des gnomes malicieux volent des objets magiques dans une maison humaine !**

---

## 📌 **À propos du jeu**
- **Genre** : Party Game / Action-Aventure / Chaos Simulator
- **Nombre de joueurs** : 1-4 (local ou en ligne)
- **Style** : 3D Cartoon (inspiré de *Burglin' Gnomes*)
- **Moteur** : Godot 4.2
- **Langage** : GDScript

---

## 🎯 **Concept**
Les joueurs incarnent des **gnomes voleurs** qui doivent **infiltrer une maison humaine** pour voler des **objets magiques** avant que le **propriétaire** ne se réveille. Chaque action bruyante (casser des objets, courir, sauter) augmente le **niveau de chaos**, ce qui risque de réveiller le propriétaire.

---

## 📥 **Installation**

### 1. Télécharger Godot 4.2
- [Télécharger Godot 4.2](https://godotengine.org/download)

### 2. Ouvrir le projet
- Lancez Godot 4.2.
- Cliquez sur **"Importer"** et sélectionnez le dossier `GnomeHeistChaos`.
- Godot va automatiquement détecter les scènes et scripts.

### 3. Lancer le jeu
- Exécutez la scène `scenes/levels/kitchen_complete.tscn` pour jouer.
- Ou exécutez `scenes/ui/main_menu_complete.tscn` pour commencer par le menu.

---

## 🎮 **Contrôles**
| Action | Clavier/Souris |
|--------|----------------|
| Déplacement | WASD |
| Sauter | Espace |
| Interagir (ramasser/lâcher) | E |
| Caméra | Souris |
| Menu Pause | Échap |

---

## 🗂 **Structure du Projet**
```
GnomeHeistChaos/
├── assets/
│   ├── models/          # Modèles 3D (.obj)
│   ├── textures/        # Textures (.png)
│   ├── audio/           # Sons (.wav)
│   └── fonts/           # Polices (.ttf)
├── scenes/
│   ├── levels/          # Niveaux (cuisine, salon, etc.)
│   ├── furniture/       # Meubles
│   ├── collectibles/    # Objets à voler
│   ├── ui/              # Interface utilisateur
│   └── player.tscn      # Joueur (gnome)
│   └── owner.tscn       # Propriétaire
├── scripts/             # Scripts GDScript
└── project.godot        # Configuration du projet
```

---

## 🎨 **Assets Inclus**

### Modèles 3D
- **4 Gnomes** : Malin, Costaud, Rapide, Magicien
- **Propriétaire** : Humain en pyjama
- **Meubles** : Table, chaise, frigo, armoire
- **Objets Magiques** : Clé dorée, baguette magique, potion rouge

### Textures
- Bois (clair, foncé, table)
- Métal (or, argent)
- Tissu (rouge, bleu, pyjama)
- Peau de gnome (verte, bleue)
- Sol (carrelage)

### Sons
- Pas de gnome
- Bruit de casse
- Ramassage d'objet
- Réveil du propriétaire
- Coup sur le propriétaire
- Musique de fond

---

## 🛠 **Personnalisation**

### Ajouter un nouveau gnome
1. Créez un modèle 3D dans `assets/models/` (format `.obj` ou `.glb`).
2. Créez une nouvelle scène dans `scenes/` (ex: `gnome_nouveau.tscn`).
3. Attachez le script `player.gd` et configurez le mesh et les textures.
4. Ajoutez le gnome dans le niveau via `kitchen_complete.tscn`.

### Ajouter un nouvel objet à voler
1. Créez un modèle 3D dans `assets/models/`.
2. Créez une nouvelle scène dans `scenes/collectibles/` (ex: `nouvel_objet.tscn`).
3. Attachez le script `collectible.gd` et configurez :
   - `item_name` : Nom de l'objet
   - `points` : Points accordés
   - `noise_value` : Niveau de bruit
4. Ajoutez l'objet dans le niveau.

### Ajouter un nouveau niveau
1. Dupliquez `kitchen_complete.tscn` et renommez-le.
2. Modifiez la disposition des meubles et objets.
3. Ajoutez le niveau dans le menu principal.

---

## 🎯 **Mécaniques de Jeu**

### Système de Chaos
- Chaque action bruyante (casser, courir, sauter) augmente le **niveau de chaos**.
- Quand le chaos atteint **100**, le propriétaire se réveille et commence à poursuivre les gnomes.
- Le niveau de chaos est affiché dans le HUD.

### Score
- Chaque objet volé rapporte des **points**.
- Le score total est affiché dans le HUD.

### Timer
- Chaque niveau a un **timer** (5 minutes par défaut).
- Si le timer atteint 0, la partie se termine.

---

## 🏆 **Modes de Jeu**

### Mode Solo
- 1 gnome contre le propriétaire.
- Objectif : Voler un maximum d'objets avant que le propriétaire ne vous attrape.

### Mode Coopératif (2-4 joueurs)
- Les gnomes travaillent ensemble pour voler les objets.
- Communication et coordination sont essentielles !

### Mode Versus (1 vs 3)
- 1 joueur incarne le **propriétaire** et doit empêcher les gnomes de voler.
- Les 3 autres joueurs sont les **gnomes**.

---

## 🐛 **Dépannage**

### Le jeu ne se lance pas
- Vérifiez que Godot 4.2 est installé.
- Vérifiez que tous les fichiers sont dans le bon dossier.
- Ouvrez la console Godot pour voir les erreurs (`F12` dans l'éditeur).

### Les modèles 3D ne s'affichent pas
- Vérifiez que les chemins des textures sont corrects dans les scènes.
- Assurez-vous que les modèles `.obj` sont valides.

### Les sons ne jouent pas
- Vérifiez que les fichiers `.wav` sont dans `assets/audio/`.
- Vérifiez que le volume n'est pas à 0 dans `audio_manager.gd`.

---

## 📜 **Licence**
Ce projet est sous licence **MIT**. Vous êtes libre de l'utiliser, le modifier et le distribuer.

---

## 🙏 **Remerciements**
- **Godot Engine** : [godotengine.org](https://godotengine.org)
- **Mixamo** : Pour les animations 3D (à intégrer manuellement).
- **Poly Haven** : Pour les textures libres de droits.
- **Freesound** : Pour les effets sonores.
- **DaFont** : Pour les polices.

---

## 📧 **Contact**
Pour toute question ou suggestion, n'hésitez pas à me contacter !

**Amusez-vous bien !** 🎉
