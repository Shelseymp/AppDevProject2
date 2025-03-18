extends Node2D

@onready var playerpop = $PlayerDied

@onready var enemypop = $EnemyDied


func _physics_process(delta):
	WhoDied()
	print("who")

	
func WhoDied():
	if Global.playerAlive == false:
		playerpop.show()
	if Global.Defeated1 == true:
		enemypop.show()
	


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_win_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
