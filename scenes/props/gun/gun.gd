extends Node2D

const bullet_scene = preload("res://scenes/props/bullet/bullet.tscn")

@onready var RotationOffset: Node2D = $RotationOffset
@onready var SpriteShadow: Sprite2D = $RotationOffset/Sprite2D/shadow
@onready var ShootPos: Marker2D = $RotationOffset/Sprite2D/shoot_pos

var time_between_shot: float = 0.25
var can_shoot: bool = true

func _ready() -> void:
	$ShootTimer.wait_time = time_between_shot

func _physics_process(delta: float) -> void:
	RotationOffset.rotation = lerp_angle(RotationOffset.rotation, (get_global_mouse_position() - global_position).angle(), 6.5 * delta)
	SpriteShadow.position = Vector2(-2, 2).rotated(-RotationOffset.rotation)
	
	if InputManager.is_shooting() and can_shoot:
		_shoot()
		can_shoot = false
		$ShootTimer.start()

func _shoot():
	var new_bullet = bullet_scene.instantiate()
	new_bullet.global_position = ShootPos.global_position
	new_bullet.global_rotation = ShootPos.global_rotation
	get_tree().root.add_child(new_bullet)

func _on_shoot_timer_timeout() -> void:
	can_shoot = true
