extends Node2D

@onready var playerpop = $PlayerDied
@onready var battle_text: Label = $BattleText

@onready var player_hit: Label = $PlayerHit
@onready var enemy_hit: Label = $EnemyHIT

@onready var enemypop = $EnemyDied

func _ready() -> void:
	BattleStart()
	Global.playerAlive = true
	Global.Defeated1 = false
	enemypop.hide()
	playerpop.hide()
	
	player_hit.hide()
	enemy_hit.hide()
	
func BattleStart():
	await get_tree().create_timer(0.5).timeout
	battle_text.show()
	await get_tree().create_timer(2.0).timeout
	battle_text.hide()
	
func _physics_process(delta):
	WhoDied()
	WhosHIT()
	#print("who")
	
#Will display whether the player or enemy is hit
func WhosHIT():
	if Global.playerHIT == true:
		player_hit.show()
		await get_tree().create_timer(0.5).timeout
		player_hit.hide()
		
	if Global.enemyHIT == true:
		enemy_hit.show()
		await get_tree().create_timer(0.5).timeout
		enemy_hit.hide()
#deciding what window will show up depending on who dies
func WhoDied():
	if Global.playerAlive == false:
		playerpop.show()
	if Global.Defeated1 == true:
		enemypop.show()
	

#changing scenes on which window and button is pressed
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_win_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
