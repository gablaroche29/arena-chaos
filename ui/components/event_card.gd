extends PanelContainer

signal finished

@onready var title: Label = $MarginContainer/HBoxContainer/VBoxContainer/EventTitle
@onready var users: Label = $MarginContainer/HBoxContainer/VBoxContainer/EventUsers

const DISPLAY_DURATION := 4.0
const SLIDE_DURATION := 0.35

const EVENT_COLORS := {
	"SPAWN_ENEMY": Color("#EF476F"),
	"EXPLOSION":   Color("#F78C6B"),
	"SPAWN_TRAP":  Color("#4CC9F0"),
}

func show_event(event: Dictionary) -> void:
	title.text = event["type"].replace("_", " ")
	users.text = "by " + ", ".join(event["users"])
	self_modulate = EVENT_COLORS.get(event["type"], Color.WHITE)

	await get_tree().process_frame

	var end_x = position.x
	var start_x = position.x - 200

	position.x = start_x

	var tween = create_tween()
	tween.tween_property(self, "position:x", end_x, SLIDE_DURATION)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_OUT)

	await get_tree().create_timer(DISPLAY_DURATION).timeout
	finished.emit()
