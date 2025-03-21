extends Control

func _ready():
	Global.load_score()  # Load previous score when the main menu appears

func _on_start_pressed() -> void:
	Global.reset_score()  # Reset score when starting a new game
	get_tree().change_scene_to_file("res://scenes/game.tscn")  # Load the game scene

func _on_load_pressed() -> void:
	Global.load_score()  # Load previous score
	get_tree().change_scene_to_file("res://scenes/game.tscn")  # Load the game scene
	print("Load Pressed - Loaded Score: " + str(Global.Score))  # Use Global.Score
