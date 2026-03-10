extends Node

signal game_victory
signal game_over

@export var level_time: float = 10.0 # 3 minutes in seconds
var timer: Timer

func _ready() -> void:
	setup_timer()
	call_deferred("connect_player_signal")

func setup_timer() -> void:
	timer = Timer.new()
	timer.wait_time = level_time
	timer.one_shot = true
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func connect_player_signal() -> void:
	var player = get_tree().get_first_node_in_group("player")
	
	if player and player.has_node("Health"):
		var health_node = player.get_node("Health")
		health_node.died.connect(_on_player_died)
	else:
		push_warning("GameManager: No player found in 'player' group or Health node missing.")

func _on_timer_timeout() -> void:
	print("Time's up! Victory!")
	game_victory.emit()

func _on_player_died() -> void:
	game_over.emit()
	if timer:
		timer.stop()
