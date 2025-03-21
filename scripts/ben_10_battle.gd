class_name PlayerEntity

extends CharacterBody2D


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


func check_hitbox():
	var hitbox_areas = $PlayHitbox.get_overlapping_areas()
	var damage : int
	if hitbox_areas:
		var hitbox = hitbox_areas.front()
		if hitbox.get_parent() is Vilgax:
			damage = Global.VilgaxDamageAmount
			if can_take_damage:
				take_damage(damage)
		

func take_damage(damage):
	if damage != 0:
		if health > 0:
			health -= damage
			print("Player Health: ", health)
			if health <= 0:
				health = 0 
				dead = true
				Global.Score = 0
				handle_death_animation()
			take_damage_cooldown(2.0)
	else:
		print("da")

func take_damage_cooldown(wait_time):
	print("cooldown")

	can_take_damage = false
	await get_tree().create_timer(wait_time).timeout
	can_take_damage = true
	
	
func handle_death_animation():
	Global.playerAlive = false
	self.queue_free()
	await get_tree().create_timer(7).timeout
	
	
	
func _ready():
	Global.playerBody = self
	Global.PlayerDamageZone = dealing_damage_zone
	
	
func toggle_damage_collisions():
	print("Toggle Damage")
	var damage_zone_collision = dealing_damage_zone.get_node("damage")
	damage_zone_collision.disabled = false
	Global.playerDealingDamage = true
	
	await get_tree().create_timer(0.2).timeout
	damage_zone_collision.disabled = true
	Global.playerDealingDamage = false 


	
func _physics_process(delta: float) -> void:
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
		
	if direction == 0:
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
