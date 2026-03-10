extends Control

@onready var bar = $HBoxContainer/ProgressBar

@export var max_chaos: int = 300
var current_event_count: int = 0

func _ready():
	EventManager.event_triggered.connect(_on_event_added)
	
	bar.max_value = max_chaos
	update_chaos(0)

func _on_event_added(_event):
	current_event_count += 1
	update_chaos(current_event_count)

func update_chaos(value):
	var display_value = clamp(value, 0, max_chaos)
	bar.value = display_value

	var percentage = (float(display_value) / max_chaos) * 100

	if percentage < 30:
		bar.modulate = Color("#06D6A0") # Green
	elif percentage < 70:
		bar.modulate = Color("#FFD166") # Yellow
	else:
		bar.modulate = Color("#EF476F") # Red
