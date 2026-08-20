extends Node3D
## kitchen.gd - Script simplifié pour le niveau cuisine

# Référence au GameManager
var game_manager: Node

func _ready() -> void:
	# Initialiser le GameManager
	game_manager = get_node("/root/GameManager")
	if game_manager:
		game_manager.start_game()
	
	# Configurer le joueur
	var player = $Players/GnomePlayer
	if player:
		player.add_to_group("players")
	
	# Configurer le propriétaire
	var owner = $Owner
	if owner:
		owner.add_to_group("owner")
