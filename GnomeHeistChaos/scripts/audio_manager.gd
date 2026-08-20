extends Node
## audio_manager.gd - Script simplifié pour la gestion des sons

# Charger les sons
@onready var sfx_pickup: AudioStream = load("res://assets/audio/pickup.wav")
@onready var sfx_break: AudioStream = load("res://assets/audio/break.wav")

# Nœuds audio
var sfx_players: Array = []

func _ready() -> void:
	# Créer 3 lecteurs pour les effets sonores
	for i in range(3):
		var player = AudioStreamPlayer.new()
		add_child(player)
		sfx_players.append(player)

func play_sfx(stream: AudioStream) -> void:
	if not stream:
		return
	
	for player in sfx_players:
		if not player.playing:
			player.stream = stream
			player.play()
			return
	
	sfx_players[0].stream = stream
	sfx_players[0].play()

func play_pickup() -> void:
	play_sfx(sfx_pickup)

func play_break() -> void:
	play_sfx(sfx_break)
