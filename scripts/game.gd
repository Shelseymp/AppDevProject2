extends Node2D

@onready var score_label: Label = $ScoreLabel

func _ready():
	update_score()  # Update score when the scene loads

func _process(delta):
	if score_label.text != "Your score is : " + str(Global.Score) + " !":
		update_score()  # Only update if the score changes

func update_score():
	score_label.text = "Your score is : " + str(Global.Score) + " !"
