extends Node2D

const  SPEED = -20

const direction = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= direction * SPEED * delta
