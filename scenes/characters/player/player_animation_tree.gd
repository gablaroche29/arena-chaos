extends Node2D

@onready var animation_tree: AnimationTree = get_node("../AnimationTree")
@onready var player: Player = get_owner()

var last_facing_direction := Vector2(0, -1)

func _ready() -> void:
	animation_tree.active = true

func _physics_process(delta: float) -> void:
	var idle = !player.velocity
	
	if !idle:
		last_facing_direction = player.velocity.normalized()
	
	animation_tree.set("parameters/PlayerStates/Idle/blend_position", last_facing_direction)
	animation_tree.set("parameters/PlayerStates/Run/blend_position", last_facing_direction)
