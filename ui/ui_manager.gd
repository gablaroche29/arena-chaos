extends CanvasLayer
class_name UIManager

func _ready():
	EventManager.event_triggered.connect(_on_event_triggered)

func _on_event_triggered(event):
	flash()

func flash():
	var flash = ColorRect.new()
	flash.color = Color(1,1,1,0.2)
	flash.size = get_viewport().get_visible_rect().size

	add_child(flash)

	var tween = create_tween()
	tween.tween_property(flash,"modulate:a",0,0.25)

	await tween.finished
	flash.queue_free()
