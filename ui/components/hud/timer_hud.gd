extends Control

@onready var label = $HBoxContainer/TimerLabel

var time_survived = 0


func _process(delta):

	time_survived += delta

	var minutes = int(time_survived) / 60
	var seconds = int(time_survived) % 60

	label.text = "%02d:%02d" % [minutes, seconds]
