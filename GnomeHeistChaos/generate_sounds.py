#!/usr/bin/env python3
"""
Générateur de sons pour Gnome Heist Chaos
Crée des sons 8-bit en WAV pour le jeu.
"""

import numpy as np
from scipy.io import wavfile
import os

# Dossier de sortie
SOUND_DIR = "/workspace/GnomeHeistChaos/assets/audio"
os.makedirs(SOUND_DIR, exist_ok=True)

# Paramètres audio
SAMPLE_RATE = 44100  # 44.1 kHz
DURATION = 0.5  # 0.5 secondes par son


def generate_sine_wave(freq: float, duration: float, volume: float = 0.5) -> np.ndarray:
    """Génère une onde sinusoïdale."""
    t = np.linspace(0, duration, int(SAMPLE_RATE * duration), False)
    wave = volume * np.sin(2 * np.pi * freq * t)
    return wave


def generate_square_wave(freq: float, duration: float, volume: float = 0.5) -> np.ndarray:
    """Génère une onde carrée."""
    t = np.linspace(0, duration, int(SAMPLE_RATE * duration), False)
    wave = volume * np.sign(np.sin(2 * np.pi * freq * t))
    return wave


def generate_triangle_wave(freq: float, duration: float, volume: float = 0.5) -> np.ndarray:
    """Génère une onde triangulaire."""
    t = np.linspace(0, duration, int(SAMPLE_RATE * duration), False)
    wave = volume * (2 / np.pi) * np.arcsin(np.sin(2 * np.pi * freq * t))
    return wave


def generate_noise(duration: float, volume: float = 0.3) -> np.ndarray:
    """Génère du bruit blanc."""
    samples = int(SAMPLE_RATE * duration)
    return volume * np.random.uniform(-1, 1, samples)


def generate_footstep_sound() -> np.ndarray:
    """Génère un son de pas (bruit + onde basse)."""
    # Mélange de bruit et d'onde basse
    noise = generate_noise(DURATION, 0.2)
    bass = generate_sine_wave(100, DURATION, 0.3)
    return noise + bass


def generate_break_sound() -> np.ndarray:
    """Génère un son de casse (bruit + ondes aiguës)."""
    # Mélange de bruit et d'ondes aiguës
    noise = generate_noise(DURATION, 0.4)
    high1 = generate_sine_wave(800, DURATION, 0.3)
    high2 = generate_sine_wave(1200, DURATION, 0.2)
    return noise + high1 + high2


def generate_pickup_sound() -> np.ndarray:
    """Génère un son de ramassage (ondes hautes et joyeuses)."""
    # Mélange d'ondes hautes
    high1 = generate_sine_wave(1000, DURATION, 0.4)
    high2 = generate_sine_wave(1500, DURATION, 0.3)
    return high1 + high2


def generate_owner_wake_sound() -> np.ndarray:
    """Génère un son de réveil (onde basse + bruit)."""
    # Mélange d'onde basse et de bruit
    bass = generate_sine_wave(50, DURATION * 2, 0.5)[:int(SAMPLE_RATE * DURATION)]
    noise = generate_noise(DURATION, 0.3)
    return bass + noise


def generate_gnome_hit_sound() -> np.ndarray:
    """Génère un son de coup (onde carrée + bruit)."""
    # Mélange d'onde carrée et de bruit
    square = generate_square_wave(200, DURATION, 0.4)
    noise = generate_noise(DURATION, 0.2)
    return square + noise


def generate_music_theme() -> np.ndarray:
    """Génère une musique de fond simple (8-bit)."""
    # Mélange de plusieurs ondes pour une mélodie
    duration = 2.0  # Plus long pour la musique
    t = np.linspace(0, duration, int(SAMPLE_RATE * duration), False)
    
    # Accords simples (C Majeur)
    c4 = generate_sine_wave(261.63, duration, 0.2)
    e4 = generate_sine_wave(329.63, duration, 0.2)
    g4 = generate_sine_wave(392.00, duration, 0.2)
    
    # Mélodie
    melody = (
        generate_sine_wave(523.25, duration, 0.3) +  # C5
        generate_sine_wave(659.25, duration, 0.2) +  # E5
        generate_sine_wave(783.99, duration, 0.1)    # G5
    )
    
    return c4 + e4 + g4 + melody


def save_wav(filename: str, wave: np.ndarray):
    """Sauvegarde une onde en fichier WAV."""
    # Normaliser l'onde pour éviter les clippings
    wave = np.clip(wave, -1.0, 1.0)
    
    # Convertir en int16 (format WAV standard)
    wave_int16 = (wave * 32767).astype(np.int16)
    
    # Sauvegarder
    wavfile.write(f"{SOUND_DIR}/{filename}", SAMPLE_RATE, wave_int16)
    print(f"Son créé: {filename}")


if __name__ == "__main__":
    print("Génération des sons en cours...")
    
    # Générer les sons
    try:
        import scipy
    except ImportError:
        print("Scipy non installé. Installation en cours...")
        import subprocess
        subprocess.run(["pip3", "install", "scipy"], check=True)
        import scipy
        from scipy.io import wavfile
    
    # Sons de pas
    save_wav("footstep.wav", generate_footstep_sound())
    
    # Son de casse
    save_wav("break.wav", generate_break_sound())
    
    # Son de ramassage
    save_wav("pickup.wav", generate_pickup_sound())
    
    # Son de réveil du propriétaire
    save_wav("owner_wake.wav", generate_owner_wake_sound())
    
    # Son de coup sur le propriétaire
    save_wav("gnome_hit.wav", generate_gnome_hit_sound())
    
    # Musique de fond
    save_wav("theme.wav", generate_music_theme())
    
    print("\n✅ Tous les sons ont été générés dans /workspace/GnomeHeistChaos/assets/audio/")
