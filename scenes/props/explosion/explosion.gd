extends Node2D

var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	$AnimationPlayer.play("play")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		body.get_node_or_null("Health").damage(1)

func _animation_finished():
	queue_free()
