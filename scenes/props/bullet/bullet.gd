extends Node2D

@onready var RayCast: RayCast2D = $RayCast2D
@onready var player = get_tree().get_first_node_in_group("player")

const speed: float = 800.0

func _physics_process(delta: float) -> void:
	global_position += Vector2(1, 0).rotated(rotation) * speed * delta
	
	if RayCast.is_colliding() and RayCast.get_collider() != player:
		queue_free()

func _on_distance_timeout_timeout() -> void:
	queue_free()
