extends Control

@onready var label = $Label

var event_id
var event_type

func setup(event):
	event_id = event.id
	event_type = event.type
	update_vote(event)

func update_vote(event):
	label.text = "%s  %d/%d votes" % [
		event.type,
		event.vote_count,
		event.vote_required
	]
