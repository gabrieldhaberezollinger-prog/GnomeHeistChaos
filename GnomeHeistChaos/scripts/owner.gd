extends CharacterBody3D
class_name HouseOwner
## owner.gd - Script du propriétaire de la maison

# États possibles
enum State { ASLEEP, AWAKENING, CHASING, STUNNED }

# Variables
@export var speed: float = 3.0  # Vitesse de déplacement (plus lent que les gnomes)
@export var chase_speed: float = 6.0  # Vitesse en mode poursuite
@export var wake_up_time: float = 2.0  # Temps pour se réveiller
@export var stun_time: float = 3.0  # Temps d'étourdissement
@export var detection_radius: float = 10.0  # Rayon de détection des gnomes

# Références
@onready var bed_position: Node3D = $BedPosition  # Position du lit
@onready var chase_target: Node3D  # Cible actuelle (gnome)

# État
var current_state: State = State.ASLEEP
var timer: float = 0.0
var players_in_range: Array[Node3D] = []  # Gnomes à proximité


func _ready() -> void:
	# Enregistrer auprès du GameManager
	var game_manager = get_node("/root/GameManager")
	if game_manager:
		game_manager.register_owner(self)
	
	# Commencer endormi
	current_state = State.ASLEEP
	global_position = bed_position.global_position


func _physics_process(delta: float) -> void:
	match current_state:
		State.ASLEEP:
			# Ne rien faire, juste vérifier si on doit se réveiller
			pass
			
		State.AWAKENING:
			# Animation de réveil
			timer -= delta
			if timer <= 0.0:
				current_state = State.CHASING
				# Trouver le gnome le plus proche
				chase_target = find_nearest_gnome()
				
				# Émettre un son de réveil
				var audio_manager = get_node("/root/AudioManager")
				if audio_manager:
					audio_manager.play_owner_wake()
			
			State.CHASING:
			# Poursuivre le gnome
			if chase_target:
				var direction = (chase_target.global_position - global_position).normalized()
				velocity.x = direction.x * chase_speed
				velocity.z = direction.z * chase_speed
			else:
				# Si plus de cible, retourner au lit
				var direction = (bed_position.global_position - global_position).normalized()
				velocity.x = direction.x * speed
				velocity.z = direction.z * speed
				
				# Si on est proche du lit, se rendormir
				if global_position.distance_to(bed_position.global_position) < 1.0:
					current_state = State.ASLEEP
					velocity = Vector3.ZERO
			
			State.STUNNED:
			# Étourdi, ne pas bouger
			timer -= delta
			if timer <= 0.0:
				current_state = State.CHASING
				chase_target = find_nearest_gnome()
	
	move_and_slide()


func wake_up() -> void:
	"""Réveiller le propriétaire."""
	if current_state == State.ASLEEP:
		current_state = State.AWAKENING
		timer = wake_up_time


func hit_by_gnome() -> void:
	"""Le propriétaire est touché par un gnome."""
	if current_state == State.CHASING:
		current_state = State.STUNNED
		timer = stun_time
		velocity = Vector3.ZERO
		
		# Émettre un son
		var audio_manager = get_node("/root/AudioManager")
		if audio_manager:
			audio_manager.play_gnome_hit()


func find_nearest_gnome() -> Node3D:
	"""Trouver le gnome le plus proche."""
	var game_manager = get_node("/root/GameManager")
	if not game_manager or not game_manager.players:
		return null
	
	var nearest_gnome: Node3D = null
	var min_distance: float = INF
	
	for player in game_manager.players:
		var distance = global_position.distance_to(player.global_position)
		if distance < min_distance and distance < detection_radius:
			min_distance = distance
			nearest_gnome = player
	
	return nearest_gnome


func reset_owner() -> void:
	"""Réinitialiser le propriétaire."""
	current_state = State.ASLEEP
	global_position = bed_position.global_position
	velocity = Vector3.ZERO
	chase_target = null


func _on_visibility_notifier_3d_screen_exited() -> void:
	# Si le propriétaire sort de l'écran, le faire revenir
	if current_state != State.ASLEEP:
		var direction = (bed_position.global_position - global_position).normalized()
		velocity.x = direction.x * speed * 2.0  # Plus rapide pour revenir
		velocity.z = direction.z * speed * 2.0
