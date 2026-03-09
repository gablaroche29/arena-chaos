extends Node
class_name EnemySpawnDirector

@export var enemy_scene: PackedScene

var spawn_points: Array[Node] = []

func _ready():
	EventManager.event_triggered.connect(_on_event_triggered)

	spawn_points = get_tree().get_nodes_in_group("enemy_spawn_points")

func _on_event_triggered(event):
	if event.type == "SPAWN_ENEMY":
		spawn_enemy()

func spawn_enemy():
	if spawn_points.is_empty():
		return

	var spawn_point = spawn_points.pick_random()

	var enemy = enemy_scene.instantiate()
	get_tree().current_scene.add_child(enemy)

	enemy.global_position = spawn_point.global_position
