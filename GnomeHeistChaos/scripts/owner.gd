extends CharacterBody3D
class_name HouseOwner
## owner.gd - Script simplifié du propriétaire

# États
@export var speed: float = 3.0
@export var chase_speed: float = 6.0

# Références
@onready var bed_position: Node3D = $BedPosition

# État
var is_asleep: bool = true
var chase_target: Node3D = null

func _ready() -> void:
	global_position = bed_position.global_position

func _physics_process(delta: float) -> void:
	if is_asleep:
		velocity = Vector3.ZERO
		return
	
	# Poursuivre le joueur
	var players = get_tree().get_nodes_in_group("players")
	if players.size() > 0:
		chase_target = players[0]
		var direction = (chase_target.global_position - global_position).normalized()
		velocity.x = direction.x * chase_speed
		velocity.z = direction.z * chase_speed
	else:
		# Retourner au lit
		var direction = (bed_position.global_position - global_position).normalized()
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		
		if global_position.distance_to(bed_position.global_position) < 1.0:
			is_asleep = true
	
	move_and_slide()

func wake_up() -> void:
	is_asleep = false
