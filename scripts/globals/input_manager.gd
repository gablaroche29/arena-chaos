extends Node

var direction: Vector2 = Vector2.ZERO

func _process(_delta: float) -> void:
	direction = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")

func is_moving() -> bool:
	return direction != Vector2.ZERO

func is_using_tool() -> bool:
	return Input.is_action_just_pressed("hit")
