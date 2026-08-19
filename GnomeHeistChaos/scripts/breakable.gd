extends StaticBody3D
class_name BreakableObject
## breakable.gd - Script pour les objets cassables (meubles, etc.)

# Variables
@export var health: int = 3  # Nombre de coups nécessaires pour casser
@export var noise_value: float = 2.0  # Niveau de bruit quand on casse
@export var broken_model: PackedScene  # Modèle à afficher quand cassé (optionnel)

# Références
@onready var mesh_instance: MeshInstance3D = $MeshInstance3D
@onready var collision_shape: CollisionShape3D = $CollisionShape3D

# État
var is_broken: bool = false


func _ready() -> void:
	pass


func break_object() -> void:
	"""Casser l'objet."""
	if is_broken:
		return
	
	health -= 1
	
	# Jouer un son de casse
	var audio_manager = get_node("/root/AudioManager")
	if audio_manager:
		audio_manager.play_break()
	
	# Ajouter du chaos
	var game_manager = get_node("/root/GameManager")
	if game_manager:
		game_manager.add_chaos(noise_value * 0.5)  # Moins de bruit que de casser complètement
	
	if health <= 0:
		# L'objet est complètement cassé
		is_broken = true
		mesh_instance.visible = false
		collision_shape.set_deferred("disabled", true)
		
		# Ajouter plus de chaos
		if game_manager:
			game_manager.add_chaos(noise_value)
			
		# Charger le modèle cassé si disponible
		if broken_model:
			var broken_instance = broken_model.instantiate()
			broken_instance.global_position = global_position
			broken_instance.global_rotation = global_rotation
			get_parent().add_child(broken_instance)


func reset_object() -> void:
	"""Réinitialiser l'objet."""
	is_broken = false
	health = 3
	mesh_instance.visible = true
	collision_shape.disabled = false
