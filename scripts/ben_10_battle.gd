class_name PlayerEntity

extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

@onready var play_hitbox: Area2D = $PlayHitbox

@onready var dealing_damage_zone: Area2D = $DealingDamageZone

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var current_attack: bool = false

var health = 100
var max_health = 100
var min_health = 0


var dead : bool = false
var taking_damage: bool = false
var dealing_damage = 20
var is_dealing_damage : bool = false

var can_take_damage:bool = true

#This will check to make sure the damage done to the player is fron vilgax
func check_hitbox():
	var hitbox_areas = $PlayHitbox.get_overlapping_areas()
	var damage : int
	if hitbox_areas:
		var hitbox = hitbox_areas.front()
		if hitbox.get_parent() is Vilgax:
			damage = Global.VilgaxDamageAmount
			if can_take_damage:
				take_damage(damage)
				
#this will check if the player is hit
func playerHITfunc():
	print("Hit")
	Global.playerHIT = true
	await get_tree().create_timer(1).timeout
	Global.playerHIT = false
	
#this will deal damage to the player
func take_damage(damage):
	if damage != 0:
		if health > 0:
			playerHITfunc()
			health -= damage
			print("Player Health: ", health)
			#this will kill the player
			if health <= 0:
				health = 0 
				dead = true
				Global.SavingScore = Global.Score
				Global.Scoretracker.append(Global.SavingScore)
				Global.number += 1
				Global.Score = 0
				handle_death()
			take_damage_cooldown(2.0)
	else:
		print("da")

#this will make sure the player doesnt die immeidiatly 
func take_damage_cooldown(wait_time):
	print("cooldown")
	can_take_damage = false
	await get_tree().create_timer(wait_time).timeout
	can_take_damage = true
	
#death 
func handle_death():
	Global.playerAlive = false
	self.queue_free()
	await get_tree().create_timer(7).timeout
	
#func Animations():
	#if Global.enemyHIT == true:
		#animated_sprite_2d.play("moveRight")
		#await get_tree().create_timer(1.8).timeout
		
#this sets the player as the player/in case of future alien transformations
func _ready():
	Global.playerBody = self
	Global.PlayerDamageZone = dealing_damage_zone
	
#This will toggle when the player can do damage after a cooldown
func toggle_damage_collisions():
	print("Toggle Damage")
	var damage_zone_collision = dealing_damage_zone.get_node("damage")
	damage_zone_collision.disabled = false
	Global.playerDealingDamage = true
	
	await get_tree().create_timer(0.2).timeout
	damage_zone_collision.disabled = true
	Global.playerDealingDamage = false 



func _physics_process(delta: float) -> void:
	if animation_player.current_animation == "Attack" and animation_player.is_playing():
		move_and_slide()
		return
	check_hitbox()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("punch"):
		toggle_damage_collisions()
		set_damage("punch")
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.  -1 0 1
	var direction := Input.get_axis("moveLeft", "moveRight")
	
	if direction > 0:
		animated_sprite_2d.play("moveRight")
		dealing_damage_zone.scale.x = 1

		
	if direction < 0:
		animated_sprite_2d.play("moveLeft")
		dealing_damage_zone.scale.x = -1
	
	#if direction == 0 and Input.is_action_just_pressed("punch"):
	#	print("PUNCHING AND STANDING")
	#	animated_sprite_2d.play("Attack")
	#	await get_tree().create_timer(7.0).timeout
		
		
	if direction == 0:
		print("STANDING")
		animated_sprite_2d.play("idle")
		

	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	
func set_damage(attack_type):
	print("setting damage")
	var current_damage_to_deal:int
	if attack_type == "punch":
		print("punching")
		current_damage_to_deal = 20
	Global.playerDamageAmount = current_damage_to_deal
