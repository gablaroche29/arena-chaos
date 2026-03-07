class_name Player
extends CharacterBody2D

const MAX_SPEED: float = 120.0 
const ACCELERATION: float = 800.0
const FRICTION: float = 1000.0

func _physics_process(delta: float) -> void:
	var direction = InputManager.direction
	
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move_and_slide()
