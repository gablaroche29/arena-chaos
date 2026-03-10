extends PanelContainer

@onready var name_label = $MarginContainer/VBoxContainer/HBoxContainer/EventName
@onready var progress = $MarginContainer/VBoxContainer/HBoxContainer2/ProgressBar
@onready var vote_text = $MarginContainer/VBoxContainer/HBoxContainer2/VoteText

var event_id
var event_type


func setup(event):

	event_id = event.id
	event_type = event.type

	name_label.text = event.type.replace("_"," ")

	progress.max_value = event.vote_required

	update_vote(event)


func update_vote(event):

	progress.value = event.vote_count

	vote_text.text = "%d / %d" % [
		event.vote_count,
		event.vote_required
	]
	var tweenProgress = create_tween()

	tweenProgress.tween_property(
		progress,
		"value",
		event.vote_count,
		0.2
	)
	
	if event.vote_required - event.vote_count <= 1:
		var tween = create_tween().set_loops()
		tween.tween_property(self,"scale",Vector2(1.03,1.03),0.4)
		tween.tween_property(self,"scale",Vector2.ONE,0.4)


func remove():

	var tween = create_tween()

	tween.tween_property(self,"modulate:a",0,0.2)
	tween.parallel().tween_property(self,"scale",Vector2(0.8,0.8),0.2)

	await tween.finished

	queue_free()
