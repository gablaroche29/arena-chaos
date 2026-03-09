class_name Player
extends CharacterBody2D

@onready var health: Health = $Health

const MAX_SPEED: float = 120.0 
const ACCELERATION: float = 800.0
const FRICTION: float = 1000.0

func _ready() -> void:
	health.died.connect(_on_died)

func _physics_process(delta: float) -> void:
	var direction = InputManager.direction
	
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move_and_slide()
	
	if direction.x > 0:
		$Sprite2D.flip_h = false
	elif direction.x < 0:
		$Sprite2D.flip_h = true

func _on_died():
	print("player has died")
