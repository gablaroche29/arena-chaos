extends Node2D

@export var follow_distance: float = 50.0
@export var vertical_offset: float = -30.0

@export var follow_smooth: float = 8.0
@export var side_switch_speed: float = 6.0

@export var hover_amplitude: float = 5.0
@export var hover_speed: float = 2.0

@export var max_distance: float = 200.0

@export var bullet_scene: PackedScene

@onready var player = get_tree().get_first_node_in_group("player")
@onready var muzzle = $Muzzle

var side_target := -1.0
var side_current := -1.0

func _physics_process(delta):

	if !player:
		return

	_update_side(delta)

	var hover = sin(Time.get_ticks_msec() * 0.001 * hover_speed) * hover_amplitude

	var target_position = player.global_position + Vector2(
		follow_distance * side_current,
		vertical_offset + hover
	)

	# snap if extremely far (dash safety)
	if global_position.distance_to(player.global_position) > max_distance:
		global_position = target_position

	# smooth movement
	global_position = global_position.lerp(target_position, follow_smooth * delta)

	# smooth rotation
	var target_angle = (get_global_mouse_position() - global_position).angle()
	rotation = lerp_angle(rotation, target_angle, 10 * delta)

	if InputManager.is_shooting():
		shoot()


func _update_side(delta):

	var v = player.velocity.x

	if v > 10:
		side_target = -1.0
	elif v < -10:
		side_target = 1.0

	side_current = lerp(side_current, side_target, side_switch_speed * delta)


func shoot():

	if !bullet_scene:
		return

	var bullet = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)

	bullet.global_position = muzzle.global_position
	bullet.rotation = (get_global_mouse_position() - muzzle.global_position).angle()
