extends Area2D

#once this collision box is entered it will tp the player to the battle screen
func _on_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://scenes/battle_screen.tscn")
	
	print("BATTLE")
