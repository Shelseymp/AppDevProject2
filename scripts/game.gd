extends Node2D

@onready var score_label: Label = $ScoreLabel

var theScore = Global.Score

func _physics_process(delta):
	print(Global.Score)
	the_score()
	
func the_score():
	score_label.text = "Your score is : " + str(theScore) + " !"
	
