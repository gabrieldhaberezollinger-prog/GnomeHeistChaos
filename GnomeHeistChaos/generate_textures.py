#!/usr/bin/env python3
"""
Générateur de textures pour Gnome Heist Chaos
Crée des textures cartoon en PNG pour les modèles 3D.
"""

from PIL import Image, ImageDraw
import numpy as np
import os

# Dossier de sortie
TEXTURE_DIR = "/workspace/GnomeHeistChaos/assets/textures"
os.makedirs(TEXTURE_DIR, exist_ok=True)

# Taille des textures (512x512 pour une bonne qualité)
TEXTURE_SIZE = (512, 512)


def create_wood_texture(filename: str, color: tuple = (139, 69, 19)):
    """Crée une texture de bois cartoon."""
    img = Image.new("RGB", TEXTURE_SIZE, color)
    draw = ImageDraw.Draw(img)
    
    # Dessiner des cercles pour imiter le bois
    for i in range(0, 512, 50):
        for j in range(0, 512, 50):
            # Cercles de couleurs variables
            circle_color = (
                min(color[0] + np.random.randint(-20, 20), 255),
                min(color[1] + np.random.randint(-20, 20), 255),
                min(color[2] + np.random.randint(-20, 20), 255)
            )
            draw.ellipse([(i, j), (i + 40, j + 40)], fill=circle_color)
    
    # Ajouter des lignes pour le grain du bois
    for i in range(0, 512, 20):
        draw.line([(i, 0), (i + 10, 512)], fill=(100, 50, 0), width=2)
    
    img.save(f"{TEXTURE_DIR}/{filename}")
    print(f"Texture créée: {filename}")


def create_metal_texture(filename: str, color: tuple = (200, 200, 200)):
    """Crée une texture de métal cartoon."""
    img = Image.new("RGB", TEXTURE_SIZE, color)
    draw = ImageDraw.Draw(img)
    
    # Ajouter des reflets métalliques
    for i in range(0, 512, 100):
        for j in range(0, 512, 100):
            # Carrés brillants
            draw.rectangle([(i, j), (i + 80, j + 80)], fill=(255, 255, 255))
    
    # Ajouter des lignes pour le métal
    for i in range(0, 512, 30):
        draw.line([(i, 0), (i, 512)], fill=(150, 150, 150), width=1)
    
    img.save(f"{TEXTURE_DIR}/{filename}")
    print(f"Texture créée: {filename}")


def create_fabric_texture(filename: str, color: tuple = (255, 100, 100)):
    """Crée une texture de tissu cartoon."""
    img = Image.new("RGB", TEXTURE_SIZE, color)
    draw = ImageDraw.Draw(img)
    
    # Ajouter des motifs de tissu
    for i in range(0, 512, 40):
        for j in range(0, 512, 40):
            # Carrés de couleur alternative
            alt_color = (
                min(color[0] + np.random.randint(-50, 50), 255),
                min(color[1] + np.random.randint(-50, 50), 255),
                min(color[2] + np.random.randint(-50, 50), 255)
            )
            draw.rectangle([(i, j), (i + 20, j + 20)], fill=alt_color)
    
    img.save(f"{TEXTURE_DIR}/{filename}")
    print(f"Texture créée: {filename}")


def create_gnome_skin_texture(filename: str, color: tuple = (100, 200, 100)):
    """Crée une texture de peau de gnome (verte)."""
    img = Image.new("RGB", TEXTURE_SIZE, color)
    draw = ImageDraw.Draw(img)
    
    # Ajouter des taches pour la peau
    for i in range(0, 512, 80):
        for j in range(0, 512, 80):
            # Taches de couleurs variables
            spot_color = (
                min(color[0] + np.random.randint(-30, 30), 255),
                min(color[1] + np.random.randint(-30, 30), 255),
                min(color[2] + np.random.randint(-30, 30), 255)
            )
            draw.ellipse([(i, j), (i + 60, j + 60)], fill=spot_color)
    
    img.save(f"{TEXTURE_DIR}/{filename}")
    print(f"Texture créée: {filename}")


def create_gnome_clothes_texture(filename: str, color: tuple = (200, 50, 50)):
    """Crée une texture de vêtements de gnome."""
    img = Image.new("RGB", TEXTURE_SIZE, color)
    draw = ImageDraw.Draw(img)
    
    # Ajouter des motifs (rayures, pois)
    for i in range(0, 512, 60):
        for j in range(0, 512, 60):
            # Pois blancs
            draw.ellipse([(i + 10, j + 10), (i + 40, j + 40)], fill=(255, 255, 255))
    
    img.save(f"{TEXTURE_DIR}/{filename}")
    print(f"Texture créée: {filename}")


def create_floor_texture(filename: str, color: tuple = (150, 150, 150)):
    """Crée une texture de sol (carrelage)."""
    img = Image.new("RGB", TEXTURE_SIZE, color)
    draw = ImageDraw.Draw(img)
    
    # Dessiner des carrelages
    for i in range(0, 512, 64):
        for j in range(0, 512, 64):
            # Carreaux de couleur alternative
            if (i // 64 + j // 64) % 2 == 0:
                draw.rectangle([(i, j), (i + 64, j + 64)], fill=(200, 200, 200))
    
    img.save(f"{TEXTURE_DIR}/{filename}")
    print(f"Texture créée: {filename}")


def create_gold_texture(filename: str, color: tuple = (255, 215, 0)):
    """Crée une texture dorée pour les objets magiques."""
    img = Image.new("RGB", TEXTURE_SIZE, color)
    draw = ImageDraw.Draw(img)
    
    # Ajouter des reflets dorés
    for i in range(0, 512, 100):
        for j in range(0, 512, 100):
            # Reflets jaunes brillants
            draw.rectangle([(i, j), (i + 80, j + 80)], fill=(255, 255, 100))
    
    img.save(f"{TEXTURE_DIR}/{filename}")
    print(f"Texture créée: {filename}")


def create_potion_texture(filename: str, color: tuple = (200, 0, 0)):
    """Crée une texture de potion (liquide rouge)."""
    img = Image.new("RGBA", TEXTURE_SIZE, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Fond transparent
    # Dessiner des bulles
    for i in range(0, 512, 30):
        for j in range(0, 512, 30):
            # Bulles de couleurs variables
            bubble_color = (
                min(color[0] + np.random.randint(-50, 50), 255),
                min(color[1] + np.random.randint(-50, 50), 255),
                min(color[2] + np.random.randint(-50, 50), 255),
                200
            )
            draw.ellipse([(i, j), (i + 20, j + 20)], fill=bubble_color)
    
    img.save(f"{TEXTURE_DIR}/{filename}")
    print(f"Texture créée: {filename}")


if __name__ == "__main__":
    print("Génération des textures en cours...")
    
    # Textures de bois
    create_wood_texture("wood_light.png", (200, 150, 100))
    create_wood_texture("wood_dark.png", (100, 50, 0))
    create_wood_texture("wood_table.png", (150, 100, 50))
    
    # Textures de métal
    create_metal_texture("metal_gold.png", (255, 215, 0))
    create_metal_texture("metal_silver.png", (200, 200, 200))
    
    # Textures de tissu
    create_fabric_texture("fabric_red.png", (255, 50, 50))
    create_fabric_texture("fabric_blue.png", (50, 50, 255))
    create_fabric_texture("pajama.png", (255, 100, 100))  # Pyjama rayé
    
    # Textures de peau de gnome
    create_gnome_skin_texture("gnome_skin_green.png", (100, 200, 100))
    create_gnome_skin_texture("gnome_skin_blue.png", (100, 100, 200))
    
    # Textures de vêtements de gnome
    create_gnome_clothes_texture("gnome_clothes_red.png", (200, 50, 50))
    create_gnome_clothes_texture("gnome_clothes_blue.png", (50, 50, 200))
    
    # Texture de sol
    create_floor_texture("floor_tiles.png", (150, 150, 150))
    
    # Texture dorée
    create_gold_texture("gold.png", (255, 215, 0))
    
    # Texture de potion
    create_potion_texture("potion_red.png", (200, 0, 0))
    
    print("\n✅ Toutes les textures ont été générées dans /workspace/GnomeHeistChaos/assets/textures/")
