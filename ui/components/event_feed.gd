extends Control

@onready var container = $MarginContainer/EventContainer

@export var event_card_scene: PackedScene

var cards: Array = []

const STACK_OFFSET := 40
const SIDE_OFFSET := -5
const MAX_EVENTS := 6


func _ready():
	EventManager.event_triggered.connect(_on_event_triggered)


func _on_event_triggered(event):

	var card = event_card_scene.instantiate()
	container.add_child(card)

	card.position = Vector2.ZERO

	card.show_event(event)

	cards.insert(0, card)

	reposition_cards()

	card.finished.connect(_on_card_finished.bind(card))

	# remove oldest if too many
	if cards.size() > MAX_EVENTS:
		cards[-1].force_remove()


func reposition_cards():

	for i in range(cards.size()):

		var card = cards[i]

		var target_pos = Vector2(
			i * SIDE_OFFSET,
			i * STACK_OFFSET
		)

		var tween = create_tween()

		tween.tween_property(
			card,
			"position",
			target_pos,
			0.25
		).set_trans(Tween.TRANS_CUBIC)


func _on_card_finished(card):

	if cards.has(card):
		cards.erase(card)

	reposition_cards()
