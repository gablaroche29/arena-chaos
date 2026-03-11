extends Area2D
class_name ExplosionDirector

@export var explosion_scene: PackedScene

func _ready():
	EventManager.event_triggered.connect(_on_event_triggered)

func _on_event_triggered(event):
	if event.type == "EXPLOSION":
		spawn_trap()

func spawn_trap():
	if explosion_scene == null:
		return
	var explosion = explosion_scene.instantiate()
	get_tree().current_scene.add_child(explosion)
	explosion.global_position = get_random_position()

func get_random_position() -> Vector2:
	var rect = $CollisionShape2D.shape
	return global_position + Vector2(
		randf_range(-rect.size.x / 2, rect.size.x / 2),
		randf_range(-rect.size.y / 2, rect.size.y / 2)
	)
