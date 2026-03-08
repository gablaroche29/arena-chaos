extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var health: Health = $Health

var speed: int = 50
var is_colliding_player: bool = false

func _ready() -> void:
	health.died.connect(_on_died)

func _physics_process(delta: float) -> void:
	if is_colliding_player: return
	
	var direction = (player.global_position - global_position).normalized()
	velocity = lerp(velocity, direction * speed, 8.5 * delta)
	move_and_slide()
	
	if direction.x > 0:
		$Sprite2D.flip_h = false
	elif direction.x < 0:
		$Sprite2D.flip_h = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		is_colliding_player = true
		print("Collided with player")

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		is_colliding_player = false

func _on_died():
	queue_free()
