extends Node

var websocket := WebSocketPeer.new()
var url := "ws://localhost:3000"

func _ready():
	print("Connecting to WebSocket server:", url)
	var err = websocket.connect_to_url(url)
	
	if err != OK:
		print("WebSocket connection failed:", err)
	else:
		print("WebSocket connection started")

func _process(_delta):
	websocket.poll()

	var state = websocket.get_ready_state()

	if state == WebSocketPeer.STATE_OPEN:
		while websocket.get_available_packet_count():
			var message = websocket.get_packet().get_string_from_utf8()
			print("[WS EVENT]: ", message)
