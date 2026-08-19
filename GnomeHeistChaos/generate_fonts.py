#!/usr/bin/env python3
"""
Générateur de polices pour Gnome Heist Chaos
Crée des fichiers de police TTF simples pour le jeu.
"""

from PIL import Image, ImageDraw, ImageFont
import numpy as np
import os

# Dossier de sortie
FONT_DIR = "/workspace/GnomeHeistChaos/assets/fonts"
os.makedirs(FONT_DIR, exist_ok=True)

# Taille de la police
FONT_SIZE = 64


def create_bubblegum_font():
    """Crée une police style Bubblegum Sans (simplifiée)."""
    # On ne peut pas créer de vraies polices TTF sans libs complexes,
    # mais on peut générer une image de texte pour l'utiliser comme texture.
    # Pour un vrai jeu, il faudrait télécharger Bubblegum Sans depuis DaFont.
    
    # Créer une image avec du texte "A" pour tester
    img = Image.new("RGBA", (256, 256), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Dessiner un "A" style cartoon
    draw.ellipse([(50, 50), (200, 150)], outline=(255, 255, 255, 255), width=10)
    draw.line([(125, 50), (125, 200)], fill=(255, 255, 255, 255), width=10)
    draw.line([(50, 125), (200, 125)], fill=(255, 255, 255, 255), width=10)
    
    img.save(f"{FONT_DIR}/bubblegum_test.png")
    print("Image de test pour Bubblegum créée (télécharge la vraie police depuis DaFont)")


def create_luckiest_guy_font():
    """Crée une police style Luckiest Guy (simplifiée)."""
    # Même principe que ci-dessus
    img = Image.new("RGBA", (256, 256), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Dessiner un "B" style cartoon
    draw.line([(50, 50), (50, 200)], fill=(255, 255, 255, 255), width=10)
    draw.arc([(50, 50), (150, 125)], 0, 180, fill=(255, 255, 255, 255), width=10)
    draw.arc([(50, 125), (150, 200)], 0, 180, fill=(255, 255, 255, 255), width=10)
    
    img.save(f"{FONT_DIR}/luckiest_guy_test.png")
    print("Image de test pour Luckiest Guy créée (télécharge la vraie police depuis DaFont)")


def download_font_info():
    """Affiche les liens pour télécharger les polices."""
    print("\n📌 Pour des polices professionnelles, télécharge ces fichiers TTF :")
    print("1. Bubblegum Sans : https://dl.dafont.com/dl/?f=bubblegum_sans")
    print("2. Luckiest Guy : https://dl.dafont.com/dl/?f=luckiest_guy")
    print("3. Press Start 2P : https://dl.dafont.com/dl/?f=press_start_2p")
    print("\nPlace-les dans /workspace/GnomeHeistChaos/assets/fonts/")


if __name__ == "__main__":
    print("Génération des images de test pour les polices...")
    create_bubblegum_font()
    create_luckiest_guy_font()
    download_font_info()
    print("\n✅ Images de test créées dans /workspace/GnomeHeistChaos/assets/fonts/")
