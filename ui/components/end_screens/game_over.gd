extends Control

@onready var status_label: Label = $CenterContainer/Label

func _ready() -> void:
	hide()
	
	GameManager.game_victory.connect(_on_victory)
	GameManager.game_over.connect(_on_defeat)
	

func _on_victory() -> void:
	show_screen("MISSION ACCOMPLISHED", Color.GREEN_YELLOW)

func _on_defeat() -> void:
	show_screen("YOU DIED", Color.INDIAN_RED)

func show_screen(text: String, color: Color) -> void:
	status_label.text = text
	status_label.add_theme_color_override("font_color", color)
	show()
	get_tree().paused = true
