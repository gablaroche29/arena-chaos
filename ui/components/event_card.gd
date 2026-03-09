extends PanelContainer

signal finished

@onready var title = $MarginContainer/HBoxContainer/VBoxContainer/EventTitle
@onready var users = $MarginContainer/HBoxContainer/VBoxContainer/EventUsers

var tween: Tween

var event_data = {
	"SPAWN_ENEMY": {
		"color": Color("#EF476F"),
	},
	"METEOR": {
		"color": Color("#F78C6B"),
	},
	"HEAL_PLAYER": {
		"color": Color("#06D6A0"),
	},
	"FREEZE": {
		"color": Color("#4CC9F0"),
	}
}

func show_event(event):
	title.text = event.type.replace("_", " ")
	users.text = "by " + ", ".join(event.users)

	if event_data.has(event.type):
		var data = event_data[event.type]
		self_modulate = data.color

	animate_in()
	await get_tree().create_timer(3).timeout
	await animate_out()
	finished.emit()

func animate_in():
	scale = Vector2(0.6,0.6)
	modulate.a = 0
	tween = create_tween()
	tween.tween_property(self,"scale",Vector2.ONE,0.25)\
		.set_trans(Tween.TRANS_BACK)
	tween.parallel().tween_property(self,"modulate:a",1,0.2)


func animate_out():
	tween = create_tween()
	tween.tween_property(self,"scale",Vector2(0.8,0.8),0.2)
	tween.parallel().tween_property(self,"modulate:a",0,0.2)
	await tween.finished
	queue_free()

func force_remove():
	await animate_out()
	finished.emit()
