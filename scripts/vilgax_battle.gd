class_name Vilgax
extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var wall_ray_cast_left = $WallCheck/Wall_RayCast_Left as RayCast2D 
@onready var wall_ray_cast_right = $WallCheck/Wall_RayCast_Right as RayCast2D 

@onready var floor_ray_cast_left = $FloorCheck/Floor_RayCast_left as RayCast2D
@onready var floor_ray_cast_right = $FloorCheck/Floor_RayCast_right as RayCast2D


@onready var player_track_raycast = $PlayerTrackerPivot/Player_Track_Raycast as RayCast2D
@onready var player_tracker_pivot = $PlayerTrackerPivot as Node2D

@onready var chase_timer = $Chase_Timer as Timer


@export var wander_speed : float = 20
@export var chase_speed : float = 40.0

var current_speed : float = 0.0
var player_found : bool = false
var player : PlayerEntity = null 


var health = 100
var max_health = 80
var min_health = 0

var dead : bool = false
var taking_damage: bool = false
var dealing_damage = 30
var is_dealing_damage : bool = false

const gravity = 900
var knockback_force = 200
var is_roaming : bool = false






enum States{
	Wander,
	Chase
}

var current_State = States.Wander

func _ready():
	player = get_tree().get_first_node_in_group("player")
	chase_timer.timeout.connect(on_timer_timeout)
	
func _physics_process(delta):
	handle_vision()
	track_player()
	#handle_movement()
	handle_animation()
	move_and_slide()
	handle_flip()
	pass
	
	
func handle_movement() -> void:
	
	if !dead and !taking_damage and !is_dealing_damage:
		var direction = global_position - player.global_position
	
		if current_State == States.Wander:
			print("wander")
			if floor_ray_cast_right.is_colliding() != true:
				current_speed = - wander_speed
				print("right floor")
			if floor_ray_cast_left.is_colliding() != true:
				current_speed = wander_speed
				print("left floor")
			if wall_ray_cast_right.is_colliding():
				current_speed = - wander_speed
				print("right")
			if wall_ray_cast_left.is_colliding():
				current_speed = wander_speed
				print("left")
			
		if current_State == States.Chase:
			if player_found == true:
				if direction.x < 0:
					current_speed = chase_speed
				else:
					current_speed = -chase_speed
		velocity.x = current_speed
	
		
	
func handle_animation():
	if !dead and !taking_damage and !is_dealing_damage:
		handle_movement()
	
func track_player():
	if player == null:
		return
	var direction_to_player: Vector2 = Vector2(player.position.x, player.position.y + 1) - player_track_raycast.position
	
	player_tracker_pivot.look_at(direction_to_player)
	
func handle_vision():
	if player_track_raycast.is_colliding():
		var collision_result = player_track_raycast.get_collider()
			
		if collision_result != player:
			return
		else:
			current_State = States.Chase
			chase_timer.start(1)
			player_found = true
	else:
		player_found = false
		
	
func handle_flip():
	var velocity_sign = sign(velocity.x)
	
	if velocity_sign < 0:
		animated_sprite_2d.play("defaultLeft")
		
	if velocity_sign > 0:
		animated_sprite_2d.play("Right")
		
		

func on_timer_timeout() -> void:
	if player_found == false:
		current_State = States.Wander
