extends Node
## game_manager.gd - Script simplifié pour la gestion du jeu

# Variables globales
var chaos_level: float = 0.0
var max_chaos: float = 100.0
var current_score: int = 0
var time_left: float = 300.0
var is_game_active: bool = false

# Références
var owner: Node3D
var players: Array = []

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func start_game() -> void:
	chaos_level = 0.0
	current_score = 0
	time_left = 300.0
	is_game_active = true
	
	# Trouver le propriétaire
	var owner_nodes = get_tree().get_nodes_in_group("owner")
	if owner_nodes.size() > 0:
		owner = owner_nodes[0]
	
	# Trouver les joueurs
	players = get_tree().get_nodes_in_group("players")

func add_chaos(amount: float) -> void:
	if not is_game_active:
		return
	
	chaos_level += amount
	chaos_level = clamp(chaos_level, 0.0, max_chaos)
	
	if chaos_level >= max_chaos and owner:
		owner.wake_up()

func add_score(points: int) -> void:
	current_score += points

func _process(delta: float) -> void:
	if is_game_active:
		time_left -= delta
		if time_left <= 0.0:
			end_game()

func end_game() -> void:
	is_game_active = false
