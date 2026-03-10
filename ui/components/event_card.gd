extends PanelContainer

signal finished

@onready var title = $MarginContainer/HBoxContainer/VBoxContainer/EventTitle
@onready var users = $MarginContainer/HBoxContainer/VBoxContainer/EventUsers

var tween: Tween

# Use a dictionary for cleaner data management
var event_data = {
	"SPAWN_ENEMY":  {"color": Color("#EF476F")},
	"METEOR":       {"color": Color("#F78C6B")},
	"HEAL_PLAYER":  {"color": Color("#06D6A0")},
	"FREEZE":       {"color": Color("#4CC9F0")},
}

func _ready():
	# Crucial: Set the pivot to the top-right so it scales "away" from the corner
	# We wait one frame to ensure size is calculated correctly
	await get_tree().process_frame
	pivot_offset = Vector2(size.x, 0)

func show_event(event):
	title.text = event.type.replace("_", " ")
	users.text = "by " + ", ".join(event.users)

	if event_data.has(event.type):
		self_modulate = event_data[event.type].color

	# Start sequence
	animate_in()
	
	# Wait for duration (consider making this a variable)
	await get_tree().create_timer(4.0).timeout
	
	# Only auto-remove if it wasn't already pushed out by the manager
	if is_inside_tree():
		await animate_out()
		finished.emit()

func animate_in():
	# Reset state for animation
	scale = Vector2(0.5, 0.5)
	modulate.a = 0
	
	if tween: tween.kill()
	tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(self, "scale", Vector2.ONE, 0.4)
	tween.tween_property(self, "modulate:a", 1.0, 0.2)


func animate_out():
	if tween: tween.kill()
	tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	
	# Shrink and slide slightly right to "exit" the screen
	tween.tween_property(self, "scale", Vector2(0.7, 0.7), 0.25)
	tween.tween_property(self, "modulate:a", 0.0, 0.2)
	tween.tween_property(self, "position:x", position.x + 50, 0.25)
	
	await tween.finished
	queue_free()

func force_remove():
	# If the manager removes it, we want it to exit immediately
	await animate_out()
	# No need to emit finished here if animate_out/show_event already handles it, 
	# but keeping it for safety with your manager logic.
