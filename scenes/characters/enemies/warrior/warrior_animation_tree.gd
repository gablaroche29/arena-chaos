extends Node2D

@onready var animation_tree: AnimationTree = get_node("../AnimationTree")
@onready var warrior: Warrior = get_owner()

var last_facing_direction := Vector2(0, -1)

func _ready() -> void:
	animation_tree.active = true
	warrior.has_attacked.connect(_on_warrior_attacked)
	warrior.died.connect(_on_died)

func _physics_process(delta: float) -> void:
	var idle = !warrior.velocity
	
	if !idle:
		last_facing_direction = warrior.velocity.normalized()
	
	animation_tree.set("parameters/LocomotionStates/Idle/blend_position", last_facing_direction)
	animation_tree.set("parameters/LocomotionStates/Run/blend_position", last_facing_direction)
	animation_tree.set("parameters/AttackBlend/blend_position", last_facing_direction)

func _on_warrior_attacked():
	animation_tree["parameters/AttackShot/request"] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE

func _on_died():
	animation_tree["parameters/DeathShot/request"] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
