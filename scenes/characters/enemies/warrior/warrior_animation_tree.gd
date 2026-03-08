extends Node2D

@export var animation_tree: AnimationTree
@onready var warrior: Warrior = get_owner()

var last_facing_direction := Vector2(0, -1)

func _ready() -> void:
	animation_tree.active = true

func _physics_process(delta: float) -> void:
	var idle = !warrior.velocity
	
	if !idle:
		last_facing_direction = warrior.velocity.normalized()
	
	animation_tree.set("parameters/WarriorStates/Idle/blend_position", last_facing_direction)
	animation_tree.set("parameters/WarriorStates/Run/blend_position", last_facing_direction)
	animation_tree.set("parameters/WarriorStates/Smash/blend_position", last_facing_direction)
