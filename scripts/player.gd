extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_VELOCITY = 900

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var falling = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var game_controller : GameController = %GameController

func _ready():
	velocity.y = 200
	
func _physics_process(delta):
	
	if not falling:
		$GPUParticles2D.emitting = false
		return
	
	if velocity.y < log(position.y) * 80:
		velocity.y += gravity * delta
	
	animated_sprite.speed_scale = velocity.y / 100
	scale = Vector2.ONE * (1 + max(0, log(position.y - 2000) / 10))
	
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
	$GPUParticles2D.emitting = true

func set_falling(is_falling: bool):
	falling = is_falling


func _on_graze_box_body_entered(body):
	#print("graze")
	$GrazeSound.stop()
	$GrazeSound.play()
	game_controller.graze += 1



func _on_hurt_box_body_entered(body):
	falling = false
	game_controller.dead()
	pass # Replace with function body.
