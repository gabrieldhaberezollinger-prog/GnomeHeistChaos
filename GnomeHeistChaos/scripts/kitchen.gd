extends Node3D
## kitchen.gd - Script pour gérer le niveau de la cuisine

# Références aux points de spawn
@onready var gnome_spawns: Array[Node3D] = [
	$SpawnPoints/GnomeSpawn1,
	$SpawnPoints/GnomeSpawn2,
	$SpawnPoints/GnomeSpawn3,
	$SpawnPoints/GnomeSpawn4
]
@onready var owner_spawn: Node3D = $SpawnPoints/OwnerSpawn

# Références aux scènes
@onready var player_scene: PackedScene = preload("res://scenes/player.tscn")
@onready var owner_scene: PackedScene = preload("res://scenes/owner.tscn")

# Référence au GameManager
@onready var game_manager: Node = get_node("/root/GameManager")

# Référence au HUD
@onready var hud: CanvasLayer = get_node("/root/HUD")

# Nombre de joueurs (1-4)
var player_count: int = 1


func _ready() -> void:
	# Initialiser le niveau
	spawn_players()
	spawn_owner()
	
	# Démarrer la partie
	if game_manager:
		game_manager.start_game()


func spawn_players() -> void:
	"""Faire apparaître les joueurs."""
	# Pour l'instant, spawner 1 joueur (à étendre pour le multijoueur)
	for i in range(player_count):
		var player = player_scene.instantiate()
		player.global_position = gnome_spawns[i % gnome_spawns.size()].global_position
		player.global_position.y += 1.0  # Un peu au-dessus du sol
		add_child(player)
		
		# Configurer l'ID du joueur
		if player.has_method("set_player_id"):
			player.set_player_id(i + 1)


func spawn_owner() -> void:
	"""Faire apparaître le propriétaire."""
	var owner = owner_scene.instantiate()
	owner.global_position = owner_spawn.global_position
	add_child(owner)


func _on_player_picked_up_item(player: GnomePlayer, item: CollectibleItem) -> void:
	"""Quand un joueur ramasse un objet."""
	if hud and hud.has_method("show_item_notification"):
		hud.show_item_notification(item.item_name)
