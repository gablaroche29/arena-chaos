extends Node2D

var player: Player

func _ready() -> void:
	$AnimationPlayer.play("idle")
	player = get_tree().get_first_node_in_group("player")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		$AnimationPlayer.play("play")
		body.get_node_or_null("Health").damage(1)

func _animation_finished():
	queue_free()
