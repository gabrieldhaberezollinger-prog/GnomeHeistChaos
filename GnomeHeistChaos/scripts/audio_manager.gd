extends Node
## AudioManager.gd - Gestion des sons et de la musique

# Références aux sons (à charger dans l'éditeur)
@export var music_theme: AudioStream
@export var sfx_pickup: AudioStream  # Son quand on ramasse un objet
@export var sfx_break: AudioStream  # Son quand on casse un objet
@export var sfx_noise: AudioStream  # Son de bruit (réveil du propriétaire)
@export var sfx_gnome_hit: AudioStream  # Son quand un gnome est touché
@export var sfx_owner_wake: AudioStream  # Son quand le propriétaire se réveille

# Nœuds audio
var music_player: AudioStreamPlayer
var sfx_players: Array[AudioStreamPlayer] = []

# Volume (0.0 à 1.0)
@export var master_volume: float = 1.0
@export var music_volume: float = 0.8
@export var sfx_volume: float = 1.0


func _ready() -> void:
	# Créer les lecteurs audio
	music_player = AudioStreamPlayer.new()
	music_player.bus = "Music"
	add_child(music_player)
	
	# Créer 5 lecteurs pour les effets sonores
	for i in range(5):
		var sfx_player = AudioStreamPlayer.new()
		sfx_player.bus = "SFX"
		add_child(sfx_player)
		sfx_players.append(sfx_player)
	
	# Jouer la musique de fond
	if music_theme:
		play_music(music_theme)


func play_music(stream: AudioStream, fade_in: float = 1.0) -> void:
	"""Joue une musique avec un fondu d'entrée."""
	if not stream:
		return
	
	music_player.stream = stream
	music_player.volume_db = linear_to_db(music_volume * master_volume)
	music_player.play()


func play_sfx(stream: AudioStream) -> void:
	"""Joue un effet sonore."""
	if not stream:
		return
	
	# Trouver un lecteur disponible
	for player in sfx_players:
		if not player.playing:
			player.stream = stream
			player.volume_db = linear_to_db(sfx_volume * master_volume)
			player.play()
			return
	
	# Si tous les lecteurs sont occupés, utiliser le premier
	sfx_players[0].stream = stream
	sfx_players[0].volume_db = linear_to_db(sfx_volume * master_volume)
	sfx_players[0].play()


func play_pickup() -> void:
	"""Joue le son de ramassage."""
	play_sfx(sfx_pickup)


func play_break() -> void:
	"""Joue le son de casse."""
	play_sfx(sfx_break)


func play_noise() -> void:
	"""Joue le son de bruit."""
	play_sfx(sfx_noise)


func play_gnome_hit() -> void:
	"""Joue le son quand un gnome est touché."""
	play_sfx(sfx_gnome_hit)


func play_owner_wake() -> void:
	"""Joue le son quand le propriétaire se réveille."""
	play_sfx(sfx_owner_wake)


func set_master_volume(volume: float) -> void:
	"""Définit le volume principal."""
	master_volume = clamp(volume, 0.0, 1.0)


func set_music_volume(volume: float) -> void:
	"""Définit le volume de la musique."""
	music_volume = clamp(volume, 0.0, 1.0)
	music_player.volume_db = linear_to_db(music_volume * master_volume)


func set_sfx_volume(volume: float) -> void:
	"""Définit le volume des effets sonores."""
	sfx_volume = clamp(volume, 0.0, 1.0)
