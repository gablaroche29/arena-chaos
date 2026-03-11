extends Control

@onready var container: VBoxContainer = $EventContainer
@export var event_card_scene: PackedScene

func _ready():
	EventManager.event_triggered.connect(_on_event_triggered)

func _on_event_triggered(event: Dictionary):
	var card = event_card_scene.instantiate()
	container.add_child(card)
	container.move_child(card, 0)
	card.show_event(event)
	card.finished.connect(_on_card_finished.bind(card))

func _on_card_finished(card):
	card.queue_free()
