extends Node

# Player & Game State Variables
var playerBody: CharacterBody2D
var playerWeaponsEquip: bool = false
var playerAlive: bool = true

var playerHIT : bool = false
var enemyHIT : bool = false

# Score System
var Score: int = 0

var SavingScore : int = 0
var Scoretracker = []
var number : int = 0

#<<<<<<< HEADdaaad
#var playerAlive: bool = true
var playerDealingDamage: bool = false
#=======
# Player Damage System
#>>>>>>> 57f5285154add6ca189f09478f3ed0e77bf652b5
var PlayerDamageZone: Area2D
var playerDamageAmount: int = 10

# Enemy Damage System
var VilgaxDamageZone: Area2D
var VilgaxDamageAmount: int = 15

# Enemy Defeat Tracking
var Defeated1: bool = false
var Defeated2: bool = false

# Saving & Loading Score
func save_score():
	var file = FileAccess.open("user://score_data.json", FileAccess.WRITE)
	var data = {"score": Score}  # Use Score instead of player_score
	file.store_string(JSON.stringify(data))
	file.close()

func load_score():
	if FileAccess.file_exists("user://score_data.json"):
		var file = FileAccess.open("user://score_data.json", FileAccess.READ)
		var data = JSON.parse_string(file.get_as_text())
		if data and "score" in data:
			Score = data["score"]  # Load into Score
		file.close()

func add_score(amount: int):
	Score += amount
	save_score()

func reset_score():
	Score = 0
	save_score()
func track_score():
	Scoretracker.append(Score)
	number += 1
