extends Node2D

var road_scene : PackedScene = load("res://road.tscn")
@export var obstacles : Array[PackedScene]
@export var obstacle_chances : Array[float]
@export var obstacle_starting : Array[float]

@export var spawn_at_player_pos_chance : float
var obstacle : Node2D
@onready var obstacle_range = $ObstacleRange
@onready var player : Node2D = get_node("../Player")

func _ready():
	if(player.position.y < 100):
		return
	
	var obstacle_chances = obstacle_chances.duplicate()
	var obstacles = obstacles.duplicate()
	for i in obstacle_starting.size():
		if position.y < obstacle_starting[i]:
			# print("rm", position.y, "<",  obstacle_starting[i])
			obstacles.remove_at(i)
			obstacle_chances.remove_at(i)
	
	
	var total_chance = obstacle_chances.reduce(func(accum, num): return accum + num)
	var random_number = randf_range(0.000001, total_chance)
	var i = 0;
	while random_number > 0:
		random_number -= obstacle_chances[i]
		i += 1
	obstacle = obstacles[i - 1].instantiate()
	
	var obstacle_x
	if randf() > spawn_at_player_pos_chance:
		obstacle_x = randf_range(-1, 1) * obstacle_range.position.x
	else:
		obstacle_x = clampf(player.position.x, -obstacle_range.position.x, obstacle_range.position.x)
	
	obstacle.position = position
	obstacle.position.x += obstacle_x
	
	add_sibling.call_deferred(obstacle)
	pass

func _on_enter_area_body_entered(body):
	var next_road = duplicate()
	next_road.position.y = position.y + 256
	
	add_sibling.call_deferred(next_road)


func _on_exit_area_body_enztered(body):
	queue_free()


func _on_tree_exited():
	if obstacle:
		obstacle.queue_free()
