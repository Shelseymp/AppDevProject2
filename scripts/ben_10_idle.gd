class_name PlayerEntity2

extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -250.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.  -1 0 1
	var direction := Input.get_axis("moveLeft", "moveRight")
	
	if direction > 0:
		animated_sprite_2d.play("moveRight")
		
	if direction < 0:
		animated_sprite_2d.play("moveLeft")
		
	if direction == 0:
		animated_sprite_2d.play("idle")
	
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
