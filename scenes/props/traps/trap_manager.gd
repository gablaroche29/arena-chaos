extends Area2D
class_name TrapSpawnZone

@export var trap_scenes: Array[PackedScene]

func _ready():
	EventManager.event_triggered.connect(_on_event_triggered)

func _on_event_triggered(event):
	if event.type == "SPAWN_TRAP":
		spawn_trap()

func spawn_trap():
	if trap_scenes.is_empty():
		return
	var trap = trap_scenes.pick_random().instantiate()
	get_tree().current_scene.add_child(trap)
	trap.global_position = get_random_position()

func get_random_position() -> Vector2:
	var rect = $CollisionShape2D.shape
	return global_position + Vector2(
		randf_range(-rect.size.x / 2, rect.size.x / 2),
		randf_range(-rect.size.y / 2, rect.size.y / 2)
	)
