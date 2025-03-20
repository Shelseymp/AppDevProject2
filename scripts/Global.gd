extends Node

var player_score = 0

func save_score():
	var file = FileAccess.open("user://score_data.json", FileAccess.WRITE)
	var data = {"score": player_score}
	file.store_string(JSON.stringify(data))
	file.close()

func load_score():
	if FileAccess.file_exists("user://score_data.json"):
		var file = FileAccess.open("user://score_data.json", FileAccess.READ)
		var data = JSON.parse_string(file.get_as_text())
		if data and "score" in data:
			player_score = data["score"]
		file.close()

var playerBody : CharacterBody2D
var playerWeaponsEquip:bool

var Score: int = 0

var playerAlive: bool = true
var PlayerDamageZone: Area2D
var playerDamageAmount: int

var VilgaxDamageZone: Area2D
var VilgaxDamageAmount: int

var Defeated1 : bool = false
var Defeated2 : bool = false
