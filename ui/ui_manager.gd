extends CanvasLayer
class_name UIManager

@onready var event_feed = $EventFeed
@onready var vote_panel = $VotePanel

func _ready():
	EventManager.vote_update.connect(_on_vote_update)
	EventManager.event_triggered.connect(_on_event_triggered)

func _on_vote_update(event):
	vote_panel.update_vote(event)

func _on_event_triggered(event):
	event_feed.show_event(event)
	vote_panel.remove_vote(event.type)
