extends Camera2D

@onready var player = %Player
var screen_shake = true
var shake_strength = 0

func _process(delta):
	position.y = player.position.y
	position.x = 0
	
	if screen_shake:
		position.x += randf_range(-1, 1) * shake_strength
		position.y += randf_range(-1, 1) * shake_strength
		pass
	
func set_screen_shake(strength : float):
	if strength:
		shake_strength = strength
		screen_shake = true
	else:
		screen_shake = false
