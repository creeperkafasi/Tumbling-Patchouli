extends Node2D

const SPEED = 100
var direction
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	direction = randi_range(0, 1) * 2 - 1
	if direction == -1:
		animated_sprite_2d.flip_h = true

func _process(delta):
	#print(position.x)
	if direction == 1 and ray_cast_right.is_colliding():
			direction = -1
			animated_sprite_2d.flip_h = true
	if direction == -1 and ray_cast_left.is_colliding():
			direction = 1
			animated_sprite_2d.flip_h = false
	position.x += direction * SPEED * delta
