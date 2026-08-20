extends CharacterBody3D
class_name GnomePlayer
## player.gd - Script simplifié du gnome jouable

# Variables
@export var speed: float = 5.0
@export var jump_velocity: float = 4.5
@export var gravity: float = -9.81

# Références
@onready var camera_pivot: Node3D = $CameraPivot
@onready var camera: Camera3D = $CameraPivot/Camera3D
@onready var interaction_ray: RayCast3D = $CameraPivot/Camera3D/InteractionRay
@onready var held_item_position: Node3D = $HeldItemPosition

# État
var current_item: Node3D = null

func _ready() -> void:
	# Activer la caméra
	camera.current = true

func _physics_process(delta: float) -> void:
	# Appliquer la gravité
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Gérer le saut
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	# Gérer le mouvement
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	# Gérer la souris pour la caméra
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		camera_pivot.rotate_y(-event.relative.x * 0.002)
		camera.rotate_x(-event.relative.y * 0.002)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2 + 0.1, PI/2 - 0.1)
