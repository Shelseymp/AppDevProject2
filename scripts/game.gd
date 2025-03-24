extends Node2D

@onready var score_label: Label = $ScoreLabel
@onready var scoress: Label = $ScoreBoard/Scoress

func _ready():
	update_score()  # Show current score
	update_scoreboard()  # Show scoreboard on scene load

func update_scoreboard():
	print("Updating Scoreboard")
	scoress.text = ""  # Clear any existing text

	var max_num = Global.number
	var i = 0
	var display_number = 1

	while i < max_num:
		scoress.text += str(display_number) + " ----- " + str(Global.Scoretracker[i]) + "\n"
		i += 1
		display_number += 1

func _process(delta):
	if score_label.text != "Your score is : " + str(Global.Score) + " !":
		update_score()

func update_score():
	score_label.text = "Your score is : " + str(Global.Score) + " !"
