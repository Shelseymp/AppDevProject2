class_name Vilgax
extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var wall_ray_cast_left = $WallCheck/Wall_RayCast_Left as RayCast2D 
@onready var wall_ray_cast_right = $WallCheck/Wall_RayCast_Right as RayCast2D 

@onready var floor_ray_cast_left = $FloorCheck/Floor_RayCast_left as RayCast2D
@onready var floor_ray_cast_right = $FloorCheck/Floor_RayCast_right as RayCast2D


@onready var player_track_raycast = $PlayerTrackerPivot/Player_Track_Raycast as RayCast2D
@onready var player_tracker_pivot = $PlayerTrackerPivot as Node2D
@onready var enemy_dealing_damage: Area2D = $EnemyDealingDamage

@onready var chase_timer = $Chase_Timer as Timer


@export var wander_speed : float = 20
@export var chase_speed : float = 40.0

var current_speed : float = 0.0
var player_found : bool = false
var player : PlayerEntity = null 


var health = 200
var max_health = 200
var min_health = 0

var dead : bool = false
var taking_damage: bool = false
var dealing_damage = 30
var is_dealing_damage : bool = false

const gravity = 900
var knockback_force = -20
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
	if Global.playerAlive:
		Global.VilgaxDamageAmount = dealing_damage
		Global.VilgaxDamageZone = enemy_dealing_damage
		
		handle_vision()
		track_player()
		#handle_movement()
		handle_animation()
		#move_and_slide()
		handle_flip()
		
	else:
		animated_sprite_2d.play("idle")
	
	
func handle_movement() -> void:
	move_and_slide()
	var direction = global_position - player.global_position
	
	if current_State == States.Wander:
		if floor_ray_cast_right.is_colliding() != true:
			current_speed = - wander_speed
		if floor_ray_cast_left.is_colliding() != true:
			current_speed = wander_speed
		if wall_ray_cast_right.is_colliding():
			current_speed = - wander_speed
		if wall_ray_cast_left.is_colliding():
			current_speed = wander_speed
			
	if current_State == States.Chase:
		if player_found == true:
			if direction.x < 0:
				current_speed = chase_speed
			else:
				current_speed = -chase_speed
				
	velocity.x = current_speed
	

func handle_animation():
	var velocity_sign = sign(velocity.x)
	if !dead and !taking_damage and !is_dealing_damage:
		
		handle_movement()
	if !dead and taking_damage and !is_dealing_damage:
		
		var knockback_dir = position.direction_to(player.position) * knockback_force
		velocity.x = knockback_dir.x
		
		#animated_sprite_2d.play("idle")
		await get_tree().create_timer(0.8).timeout
		
		
		#await get_tree().create_timer(0.3).timeout

		
		await get_tree().create_timer(0.8).timeout
		taking_damage = false
	elif dead:
		animated_sprite_2d.play("idle")
		await get_tree().create_timer(1.).timeout
		handle_death()

func handle_death():
	Global.Score += 10
	Global.Defeated1 = true
	self.queue_free() #dissapears from map
	#we will add the score and returning to game screen
	print("The Score is ", Global.Score)
	pass
	
	
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


func _on_enemy_hitbox_area_entered(area: Area2D) -> void:
	var damage = Global.playerDamageAmount
	if Global.playerDealingDamage == true:
		if area == Global.PlayerDamageZone:
			take_damage(damage)
		print("Damage")
		await get_tree().create_timer(0.5).timeout
	
	
func take_damage(damage):
	
	health -= damage
	taking_damage = true
	if health <= min_health:
		health = min_health
		dead = true
		
	print("Vilgax current health is " , health)
		
