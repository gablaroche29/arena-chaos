extends Control

@onready var label = $HBoxContainer/TimerLabel

var time_survived = 0


func _process(delta):
	var minutes = int(GameManager.timer.time_left) / 60
	var seconds = int(GameManager.timer.time_left) % 60

	label.text = "%02d:%02d" % [minutes, seconds]
