extends Node2D

@onready var playerpop = $PlayerDied
@onready var battle_text: Label = $BattleText

@onready var enemypop = $EnemyDied

func _ready() -> void:
	BattleStart()
	Global.playerAlive = true
	Global.Defeated1 = false
	enemypop.hide()
	playerpop.hide()
	
func BattleStart():
	await get_tree().create_timer(0.5).timeout
	battle_text.show()
	await get_tree().create_timer(2.0).timeout
	battle_text.hide()
	
func _physics_process(delta):
	WhoDied()
	#print("who")

	
func WhoDied():
	if Global.playerAlive == false:
		playerpop.show()
	if Global.Defeated1 == true:
		enemypop.show()
	


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_win_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
