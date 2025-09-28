extends Control
# "192.168.1.75" IP ZAZA
#"127.0.0.1" IP BASE
var IP_ADDRESS = "158.41.57.177"
var PORT = 12345
var MAX_CLIENTS = 5


#var isConnected = false

func _ready() -> void:
	#connect signal of connection with function
	multiplayer.peer_connected.connect(on_connection)
	multiplayer.peer_disconnected.connect(on_disconnection)
	multiplayer.server_disconnected.connect(on_server_disconnected)

	#other potential signal on client only
	'multiplayer.connected_to_server
	multiplayer.connection_failed
	multiplayer.server_disconnected'





func _on_button_quit_pressed() -> void:
	multiplayer.multiplayer_peer = null
	get_tree().quit()
	


func _on_button_play_pressed() -> void:

	get_tree().change_scene_to_file("res://world/main.tscn")
		
		
	


		
func _on_button_host_pressed() -> void:
		# Create server.
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT, MAX_CLIENTS)
	multiplayer.multiplayer_peer = peer
	$Panel/Button_play.disabled = false
	$Panel/Button_host/Label2.text = "Server Online"
	$Panel/Button_host.disabled = true



func on_connection(id):
	print("connected to server")
	if !multiplayer.is_server():
		$Panel/Button_connect/Label2.text = "Connected"
		#isConnected = true
		$Panel/Button_play.disabled = false


func on_disconnection(id):
	print("disconnected to server")
	$Panel/Button_connect/Label2.text = "Disconnected"
	#isConnected = false
	$Panel/Button_play.disabled = true



func _on_button_connect_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	#var ip = $Panel/Button_connect/Label.text
	peer.create_client(IP_ADDRESS, PORT)
	multiplayer.multiplayer_peer = peer


func on_server_disconnected():
	print("server dis-connected ")
