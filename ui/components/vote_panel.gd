extends Control

@onready var container = $VoteContainer
@export var vote_entry_scene: PackedScene

var entries = {}

func update_vote(event):
	if not entries.has(event.id):
		var entry = vote_entry_scene.instantiate()
		container.add_child(entry)
		entry.setup(event)
		entries[event.id] = entry
	else:
		entries[event.id].update_vote(event)

func remove_vote(event_type):
	for id in entries.keys():
		if entries[id].event_type == event_type:
			entries[id].queue_free()
			entries.erase(id)
			return
