extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var falling = false

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	velocity.y = 200
	
func _physics_process(delta):
	if falling:
		velocity.y += 100 * delta
		if velocity.y > 300:
			velocity.y = 300
		
		if velocity.y > 100:
			$GPUParticles2D.emitting = true
		else:
			$GPUParticles2D.emitting = false
		
		animated_sprite.speed_scale = velocity.y / 100
		
		var direction = Input.get_axis("Left", "Right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		move_and_slide()

func anim_walk(speed : float = 1):
	animated_sprite.animation = "walk"
	animated_sprite.speed_scale = speed

func anim_idle():
	animated_sprite.animation = "idle"

func anim_tumble():
	animated_sprite.animation = "tumbling"

func set_falling(is_falling: bool):
	falling = is_falling


func _on_graze_box_body_entered(body):
	print("graze")
	$GrazeSound.stop()
	$GrazeSound.play()
	# TODO(After Point System): Add graze points

