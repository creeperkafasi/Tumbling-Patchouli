class_name GameController
extends Node

var graze = 0
var points : int = 0
@onready var player = %Player
var points_offset
@onready var animation_player = $AnimationPlayer

func _ready():
	points_offset = player.position.y

func _process(delta):
	points = clampi(player.position.y + points_offset, 0, 99999999999999)
	#print(points)

func dead():
	animation_player.play("dead")
	pass
