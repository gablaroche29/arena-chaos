extends Node

@export var enemy_scene: PackedScene
@onready var spawner = $Spawner

func _ready():
	EventManager.event_triggered.connect(_on_event_triggered)

func _on_event_triggered(event):
	if event.type == "SPAWN_ENEMY":
		spawn_enemy()

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	get_tree().root.add_child(enemy)

	enemy.global_position = spawner.global_position
