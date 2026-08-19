extends Node
## GameManager.gd - Gestion globale du jeu (score, chaos, état du jeu)

# Signaux
signal game_over(winner: String)  # Émis quand la partie est terminée
signal chaos_updated(chaos_level: float)  # Émis quand le niveau de chaos change

# Variables globales
var chaos_level: float = 0.0  # Niveau de chaos (0.0 à 100.0)
var max_chaos: float = 100.0  # Seuil pour réveiller le propriétaire
var current_score: int = 0  # Score actuel (nombre d'objets volés)
var time_left: float = 300.0  # Temps restant en secondes (5 minutes par défaut)
var is_game_active: bool = false  # Si la partie est en cours

# Références aux nœuds
var owner: Node3D  # Référence au propriétaire
var players: Array[Node3D] = []  # Liste des gnomes joueurs


func _ready() -> void:
	# Initialisation du jeu
	process_mode = Node.PROCESS_MODE_ALWAYS
	

func start_game() -> void:
	"""Démarre une nouvelle partie."""
	chaos_level = 0.0
	current_score = 0
	time_left = 300.0
	is_game_active = true
	
	# Réveiller tous les joueurs
	for player in players:
		if player.has_method("reset_player"):
			player.reset_player()
	
	# Réinitialiser le propriétaire
	if owner and owner.has_method("reset_owner"):
		owner.reset_owner()
	
	# Démarrer le timer
	$Timer.start(time_left)


func end_game(winner: String) -> void:
	"""Termine la partie."""
	is_game_active = false
	game_over.emit(winner)


func add_chaos(amount: float) -> void:
	"""Ajoute du chaos au niveau actuel."""
	if not is_game_active:
		return
	
	chaos_level += amount
	chaos_level = clamp(chaos_level, 0.0, max_chaos)
	chaos_updated.emit(chaos_level)
	
	# Si le chaos atteint le maximum, réveiller le propriétaire
	if chaos_level >= max_chaos and owner:
		if owner.has_method("wake_up"):
			owner.wake_up()


func add_score(points: int) -> void:
	"""Ajoute des points au score."""
	current_score += points


func _process(delta: float) -> void:
	if is_game_active:
		# Mettre à jour le timer
		time_left -= delta
		if time_left <= 0.0:
			end_game("Propriétaire" if chaos_level < max_chaos else "Gnomes")


func register_player(player: Node3D) -> void:
	"""Enregistre un joueur."""
	if player not in players:
		players.append(player)


func register_owner(owner_node: Node3D) -> void:
	"""Enregistre le propriétaire."""
	owner = owner_node


func get_chaos_percentage() -> float:
	"""Retourne le pourcentage de chaos (0.0 à 1.0)."""
	return chaos_level / max_chaos
