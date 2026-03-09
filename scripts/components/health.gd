class_name Health
extends Node

signal health_changed(current, max)
signal died

@export var max_health: int = 10
var current_health: int
var dead: bool = false

func _ready():
	current_health = max_health
	emit_signal("health_changed", current_health, max_health)

func damage(amount: int):
	if amount <= 0 || dead:
		return
		
	current_health -= amount
	current_health = max(current_health, 0)
	
	emit_signal("health_changed", current_health, max_health)
	
	if current_health == 0:
		die()

func heal(amount: int):
	if amount <= 0:
		return
		
	current_health += amount
	current_health = min(current_health, max_health)
	
	emit_signal("health_changed", current_health, max_health)

func die():
	dead = true
	emit_signal("died")
