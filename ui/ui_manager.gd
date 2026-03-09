extends CanvasLayer
class_name UIManager

@onready var event_feed = $EventFeed
@onready var vote_panel = $VotePanel

func _ready():
	EventManager.vote_update.connect(_on_vote_update)
	EventManager.event_triggered.connect(_on_event_triggered)

func _on_vote_update(event):
	vote_panel.update_vote(event)

func _on_event_triggered(event):
	flash()
	shake_camera()
	event_feed.show_event(event)
	vote_panel.remove_vote(event.type)

func flash():
	var flash = ColorRect.new()
	flash.color = Color(1,1,1,0.2)
	flash.size = get_viewport().get_visible_rect().size

	add_child(flash)

	var tween = create_tween()
	tween.tween_property(flash,"modulate:a",0,0.25)

	await tween.finished
	flash.queue_free()
	
func shake_camera():
	var camera = get_viewport().get_camera_2d()
	if camera == null:
		return

	for i in 6:
		camera.offset = Vector2(randf_range(-6,6), randf_range(-6,6))
		await get_tree().create_timer(0.03).timeout

	camera.offset = Vector2.ZERO
