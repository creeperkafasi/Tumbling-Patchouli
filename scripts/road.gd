extends Node2D

var road_scene : PackedScene = load("res://road.tscn")
@export var obstacles : Array[PackedScene] 
var obstacle : Node2D
@onready var obstacle_range = $ObstacleRange

func _ready():
	var obstacle_x = randf_range(-1, 1) * obstacle_range.position.x
	
	obstacle = obstacles[randi_range(0, obstacles.size() - 1)].instantiate()
	
	obstacle.position = position
	obstacle.position.x += obstacle_x
	
	add_sibling.call_deferred(obstacle)
	pass

func _on_enter_area_body_entered(body):
	var next_road = duplicate()
	next_road.position.y = position.y + 256
	
	add_sibling.call_deferred(next_road)
	pass # Replace with function body.


func _on_exit_area_body_entered(body):
	queue_free()
	pass # Replace with function body.


func _on_tree_exited():
	obstacle.queue_free()
	pass # Replace with function body.
