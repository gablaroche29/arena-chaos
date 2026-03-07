extends Area2D

@export var speed: float = 500.0

func _process(delta: float) -> void:
	# Move forward based on the rotation set by the companion
	position += Vector2.RIGHT.rotated(rotation) * speed * delta

func _on_body_entered(body):
	# Handle hitting enemies here
	queue_free()
