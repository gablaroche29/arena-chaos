extends Camera2D

func _ready():
	EventManager.event_triggered.connect(_on_event_triggered)

func _on_event_triggered(event):
	shake_camera()
	
func shake_camera():
	for i in 6:
		offset = Vector2(randf_range(-6,6), randf_range(-6,6))
		await get_tree().create_timer(0.03).timeout

	offset = Vector2.ZERO
