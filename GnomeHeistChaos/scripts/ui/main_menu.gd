extends Control
## main_menu.gd - Script du menu principal

# Références aux nœuds
@onready var play_button: Button = $Buttons/PlayButton
@onready var coop_button: Button = $Buttons/CoopButton
@onready var versus_button: Button = $Buttons/VersusButton
@onready var settings_button: Button = $Buttons/SettingsButton
@onready var quit_button: Button = $Buttons/QuitButton


func _ready() -> void:
	# Connecter les signaux (déjà fait dans la scène, mais on peut le faire ici aussi)
	pass


func _on_play_pressed() -> void:
	"""Bouton Play pressé - Démarrer une partie solo."""
	# Charger la scène de la cuisine
	get_tree().change_scene_to_file("res://scenes/kitchen.tscn")


func _on_coop_pressed() -> void:
	"""Bouton Co-op pressé - Démarrer une partie coopérative."""
	# Pour l'instant, charger la cuisine (à étendre pour le multijoueur)
	get_tree().change_scene_to_file("res://scenes/kitchen.tscn")


func _on_versus_pressed() -> void:
	"""Bouton Versus pressé - Démarrer une partie versus."""
	# Pour l'instant, charger la cuisine (à étendre pour le versus)
	get_tree().change_scene_to_file("res://scenes/kitchen.tscn")


func _on_settings_pressed() -> void:
	"""Bouton Settings pressé - Ouvrir les paramètres."""
	# À implémenter
	print("Settings pressed")


func _on_quit_pressed() -> void:
	"""Bouton Quit pressé - Quitter le jeu."""
	get_tree().quit()
