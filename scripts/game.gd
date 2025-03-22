extends Node2D

@onready var score_label: Label = $ScoreLabel
@onready var scoress: Label = $ScoreBoard/Scoress

func _ready():
	update_score()  # Update score when the scene loads
	
	var MaxNUM = Global.number
	var loopingNUM = 1
	var n = 0
	while n < Global.number:
		scoress.text += str(loopingNUM) + " ----- " + str(Global.Scoretracker[n]) + "\n"
		loopingNUM += 1
	

func _process(delta):
	if score_label.text != "Your score is : " + str(Global.Score) + " !":
		update_score()  # Only update if the score changes

func update_score():
	score_label.text = "Your score is : " + str(Global.Score) + " !"
