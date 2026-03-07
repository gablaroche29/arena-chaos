extends Node

signal info(message)
signal vote_update(event)
signal event_triggered(event)

func handle_raw_message(message: String):
	var data = JSON.parse_string(message)
	
	if data == null:
		print("Invalid JSON:", message)
		return
	
	if not data.has("type"):
		print("Unknown message format:", data)
		return
	
	match data.type:
		"INFO":
			_handle_info(data)
			
		"VOTE_UPDATE":
			_handle_vote_update(data)
			
		"EVENT_TRIGGERED":
			_handle_event_triggered(data)
			
		_:
			print("Unhandled event type:", data.type)


func _handle_info(data):
	emit_signal("info", data.message)


func _handle_vote_update(data):
	emit_signal("vote_update", data.event)


func _handle_event_triggered(data):
	emit_signal("event_triggered", data.event)
