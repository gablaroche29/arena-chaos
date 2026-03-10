extends Control

@onready var bar = $HBoxContainer/ProgressBar
@onready var text = $HBoxContainer/HealthText

var player: Player
var playerHealth: Health

func _ready() -> void:
	playerHealth = get_tree().get_first_node_in_group("player").get_node_or_null("Health")
	playerHealth.health_changed.connect(_update_health)
	_update_health(playerHealth.current_health, playerHealth.max_health)

func _update_health(current_health, max_health):
	bar.max_value = max_health
	bar.value = current_health
	text.text = "%d / %d" % [current_health, max_health]
