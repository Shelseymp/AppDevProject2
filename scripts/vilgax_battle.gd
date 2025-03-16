extends CharacterBody2D

@onready var wall_ray_cast_left = $WallCheck/Wall_RayCast_Left as RayCast2D 
@onready var wall_ray_cast_right = $WallCheck/Wall_RayCast_Right as RayCast2D 

@onready var player_track_raycast = $PlayerTrackerPivot/Player_Track_Raycast as RayCast2D

@onready var player_tracker_pivot = $PlayerTrackerPivot as Node2D

@export var wander_speed : float = 40
@export var chase_speed : float = 80.0

var current_speed : float = 0.0
var player_found : bool = false

func _ready() -> void:
	pass
