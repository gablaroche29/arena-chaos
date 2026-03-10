extends Control

@onready var container = $MarginContainer/PanelContainer/MarginContainer/VoteContainer

@export var vote_entry_scene: PackedScene

var entries = {}


func _ready():
	EventManager.vote_update.connect(_on_vote_update)
	EventManager.event_triggered.connect(_on_event_triggered)


func _on_vote_update(event):

	if not entries.has(event.id):

		var entry = vote_entry_scene.instantiate()
		container.add_child(entry)

		entry.setup(event)

		entries[event.id] = entry

	else:

		entries[event.id].update_vote(event)


func _on_event_triggered(event):

	for id in entries.keys():

		var entry = entries[id]

		if entry.event_type == event.type:

			entry.remove()

			entries.erase(id)

			break
