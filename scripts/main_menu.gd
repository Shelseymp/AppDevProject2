extends Control


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_load_pressed() -> void:
	print("Load Pressed")
