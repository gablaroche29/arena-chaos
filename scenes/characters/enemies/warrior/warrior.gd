class_name Warrior
extends CharacterBody2D

@onready var health: Health = $Health

signal has_attacked()
signal died()

var speed: int = randi_range(30, 60)
var stop_distance: float = 20.0
var is_attacking: bool = false
var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	health.died.connect(_on_died)

func _physics_process(delta: float) -> void:
	if is_attacking or health.dead:
		velocity = Vector2.ZERO
		return
	
	var to_player = player.global_position - global_position
	var distance = to_player.length()
	if distance > stop_distance:
		var direction = to_player.normalized()
		velocity = velocity.move_toward(direction * speed, speed * delta * 10)
		$Sprite2D.scale.x = sign(direction.x)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed * delta * 10)
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player and not is_attacking and not health.dead:
		is_attacking = true
		has_attacked.emit()

func _has_attacked() -> void:
	var targets = $Sprite2D/AttackHitBox.get_overlapping_bodies()
	for target in targets:
		if target == player:
			target.get_node_or_null("Health").damage(1)

func _has_finished_attacking():
	is_attacking = false

func _on_died():
	is_attacking = false
	velocity = Vector2.ZERO
	died.emit()
