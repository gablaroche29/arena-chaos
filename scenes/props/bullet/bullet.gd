extends Node2D

@export var speed: float = 800.0
@export var damage: int = 2

func _physics_process(delta: float) -> void:
	global_position += Vector2.RIGHT.rotated(rotation) * speed * delta

func _on_area_2d_body_entered(body: Node) -> void:
	if body.is_in_group("enemy"):
		var health = body.get_node_or_null("Health")
		if health and health is Health:
			health.damage(damage)

	queue_free()

func _on_distance_timeout_timeout() -> void:
	queue_free()
