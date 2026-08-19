extends Area3D
class_name CollectibleItem
## collectible.gd - Script pour les objets à voler

# Variables
@export var item_name: String = "Objet Magique"  # Nom de l'objet
@export var points: int = 10  # Points accordés quand on le ramasse
@export var noise_value: float = 1.5  # Niveau de bruit quand on le ramasse

# Références
@onready var mesh_instance: MeshInstance3D = $MeshInstance3D
@onready var collision_shape: CollisionShape3D = $CollisionShape3D

# État
var is_collected: bool = false
var original_position: Vector3


func _ready() -> void:
	original_position = global_position
	
	# Connecter le signal de collision
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node3D) -> void:
	"""Quand un gnome entre en collision avec l'objet."""
	if is_collected:
		return
	
	# Vérifier si c'est un joueur
	if body is GnomePlayer and not is_collected:
		body.pick_up_item(self)


func pick_up(player: GnomePlayer) -> void:
	"""Ramasser l'objet."""
	is_collected = true
	
	# Désactiver les collisions
	collision_shape.set_deferred("disabled", true)
	mesh_instance.set_deferred("visible", false)
	
	# Ajouter des points au score
	var game_manager = get_node("/root/GameManager")
	if game_manager:
		game_manager.add_score(points)
		game_manager.add_chaos(noise_value)
	
	# Jouer un son
	var audio_manager = get_node("/root/AudioManager")
	if audio_manager:
		audio_manager.play_pickup()
	
	# Émettre un signal (optionnel)
	signal_picked_up.emit(player)


func drop() -> void:
	"""Lâcher l'objet (si le joueur le lâche)."""
	is_collected = false
	
	# Réactiver les collisions
	collision_shape.disabled = false
	mesh_instance.visible = true
	
	# Réinitialiser la position
	global_position = original_position


func reset_item() -> void:
	"""Réinitialiser l'objet."""
	is_collected = false
	collision_shape.disabled = false
	mesh_instance.visible = true
	global_position = original_position


# Signal émis quand l'objet est ramassé
signal picked_up(player: GnomePlayer)
