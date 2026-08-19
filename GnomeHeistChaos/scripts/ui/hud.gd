extends CanvasLayer
## hud.gd - Script du HUD (Head-Up Display)

# Références aux nœuds
@onready var chaos_bar: TextureProgressBar = $ChaosMeter/ChaosBar
@onready var score_label: Label = $ScoreDisplay/ScoreLabel
@onready var timer_label: Label = $TimerDisplay/TimerLabel
@onready var item_notification: Label = $ItemNotification
@onready var game_over_panel: Control = $GameOver

# Référence au GameManager
@onready var game_manager: Node = get_node("/root/GameManager")


func _ready() -> void:
	# Connecter les signaux du GameManager
	if game_manager:
		game_manager.chaos_updated.connect(_on_chaos_updated)
		game_manager.game_over.connect(_on_game_over)
	
	# Mettre à jour l'affichage initial
	update_score(0)
	update_timer(300.0)


func _process(delta: float) -> void:
	# Mettre à jour le timer en temps réel
	if game_manager and game_manager.is_game_active:
		update_timer(game_manager.time_left)


func _on_chaos_updated(chaos_level: float) -> void:
	"""Mettre à jour la barre de chaos."""
	chaos_bar.value = chaos_level
	
	# Changer la couleur en fonction du niveau de chaos
	if chaos_level > 80:
		chaos_bar.tint_color = Color.RED
	elif chaos_level > 50:
		chaos_bar.tint_color = Color.ORANGE
	else:
		chaos_bar.tint_color = Color.GREEN


func update_score(score: int) -> void:
	"""Mettre à jour l'affichage du score."""
	score_label.text = "SCORE: %d" % score


func update_timer(time_left: float) -> void:
	"""Mettre à jour l'affichage du timer."""
	var minutes: int = int(time_left) / 60
	var seconds: int = int(time_left) % 60
	timer_label.text = "%02d:%02d" % [minutes, seconds]


func show_item_notification(item_name: String) -> void:
	"""Afficher une notification quand un objet est ramassé."""
	item_notification.text = "+ %s!" % item_name
	item_notification.visible = true
	
	# Cacher après 2 secondes
	await get_tree().create_timer(2.0).timeout
	item_notification.visible = false


func _on_game_over(winner: String) -> void:
	"""Afficher l'écran de fin de partie."""
	game_over_panel.visible = true
	$GameOver/WinnerLabel.text = "Winner: %s!" % winner


func _on_restart_pressed() -> void:
	"""Redémarrer la partie."""
	game_over_panel.visible = false
	
	# Recharger la scène actuelle
	var current_scene = get_tree().current_scene
	get_tree().reload_current_scene()
