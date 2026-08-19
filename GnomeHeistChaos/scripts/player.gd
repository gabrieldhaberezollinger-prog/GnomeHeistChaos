extends CharacterBody3D
class_name GnomePlayer
## player.gd - Script du gnome jouable

# Signaux
signal picked_up_item(item: Node3D)  # Émis quand le gnome ramasse un objet
signal made_noise(noise_level: float)  # Émis quand le gnome fait du bruit

# Variables
@export var speed: float = 5.0  # Vitesse de déplacement
@export var jump_velocity: float = 4.5  # Vitesse de saut
@export var gravity: float = -9.81  # Gravité
@export var noise_multiplier: float = 1.0  # Multiplicateur de bruit (dépend du gnome)

# Références
@onready var camera_pivot: Node3D = $CameraPivot
@onready var camera: Camera3D = $CameraPivot/Camera3D
@onready var interaction_ray: RayCast3D = $CameraPivot/Camera3D/InteractionRay
@onready var held_item_position: Node3D = $HeldItemPosition

# État
var current_item: Node3D = null  # Objet actuellement tenu
var is_interacting: bool = false  # Si le gnome est en train d'interagir
var player_id: int = 0  # ID du joueur (pour le multijoueur)


func _ready() -> void:
	# Configurer la caméra pour le multijoueur
	if multiplayer.is_multiplayer():
		# Dans un jeu multijoueur, chaque joueur a sa propre caméra
		camera.current = true
	else:
		# En solo, activer la caméra
		camera.current = true
	
	# Enregistrer le joueur auprès du GameManager
	var game_manager = get_node("/root/GameManager")
	if game_manager:
		game_manager.register_player(self)


func _physics_process(delta: float) -> void:
	# Appliquer la gravité
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Gérer le saut
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		# Faire un petit bruit en sautant
		made_noise.emit(0.5 * noise_multiplier)
	
	# Gérer le mouvement
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	# Gérer l'interaction
	if Input.is_action_just_pressed("interact") and not is_interacting:
		interact()
	
	move_and_slide()


func interact() -> void:
	"""Interagir avec l'environnement."""
	if current_item:
		# Si on tient déjà un objet, le lâcher
		drop_item()
		return
	
	# Vérifier si on regarde un objet interactif
	if interaction_ray.is_colliding():
		var target = interaction_ray.get_collider()
		
		# Si c'est un objet à voler
		if target.has_method("pick_up"):
			current_item = target
			target.pick_up(self)
			made_noise.emit(1.0 * noise_multiplier)  # Faire du bruit en ramassant
			
		# Si c'est un meuble cassable
		elif target.has_method("break_object"):
			target.break_object()
			made_noise.emit(2.0 * noise_multiplier)  # Faire beaucoup de bruit
			
		# Si c'est le propriétaire (en mode versus)
		elif target.has_method("hit_by_gnome"):
			target.hit_by_gnome()
			made_noise.emit(3.0 * noise_multiplier)  # Faire énormément de bruit


func drop_item() -> void:
	"""Lâcher l'objet tenu."""
	if current_item:
		current_item.drop()
		current_item = null


func hold_item(item: Node3D) -> void:
	"""Tenir un objet."""
	current_item = item
	# Attacher l'objet à la position de tenue
	item.reparent(held_item_position)
	item.position = Vector3.ZERO
	item.rotation = Vector3.ZERO


func reset_player() -> void:
	"""Réinitialiser le joueur."""
	if current_item:
		current_item.drop()
		current_item = null
	
	# Réinitialiser la position (à implémenter selon le niveau)
	global_position = Vector3(0, 1, 0)
	velocity = Vector3.ZERO


func _input(event: InputEvent) -> void:
	# Gérer la souris pour la caméra
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		camera_pivot.rotate_y(-event.relative.x * 0.002)
		camera.rotate_x(-event.relative.y * 0.002)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2 + 0.1, PI/2 - 0.1)


func set_player_id(id: int) -> void:
	"""Définir l'ID du joueur."""
	player_id = id
