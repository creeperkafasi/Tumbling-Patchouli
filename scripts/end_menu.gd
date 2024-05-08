extends Node2D

@onready var game_controller : GameController = %GameController
@onready var score_value_label = $ScoreValueLabel
@onready var graze_value_label = $GrazeValueLabel

func _process(delta):
	score_value_label.text = "%06dm" % game_controller.points
	graze_value_label.text = str(game_controller.graze)
func _on_exit_button_pressed():
	get_tree().quit()

func _on_retry_button_pressed():
	get_tree().reload_current_scene()
