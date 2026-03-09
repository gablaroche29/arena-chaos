extends Control

@onready var container = $EventContainer

@export var event_label_scene: PackedScene


func show_event(event):
	var label = event_label_scene.instantiate()
	var users = ", ".join(event.users)
	label.text = "⚡ %s triggered by %s" % [event.type, users]
	container.add_child(label)
	# remove after few seconds
	await get_tree().create_timer(4.0).timeout
	if label:
		label.queue_free()
