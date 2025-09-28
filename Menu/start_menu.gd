extends Control
# "192.168.1.75" IP ZAZA
#"127.0.0.1" IP BASE
var IP_ADDRESS = "192.168.1.75"
var PORT = 33661
var MAX_CLIENTS = 5

var isConnected = false

func _ready() -> void:
	#connect signal of connection with function
	multiplayer.peer_connected.connect(on_connection)
	multiplayer.peer_disconnected.connect(on_disconnection)

	#other potential signal on client only
	'multiplayer.connected_to_server
	multiplayer.connection_failed
	multiplayer.server_disconnected'





func _on_button_quit_pressed() -> void:
	get_tree().quit()
	


func _on_button_play_pressed() -> void:
	if isConnected:
		pass
			# Create client
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(IP_ADDRESS, PORT)
	multiplayer.multiplayer_peer = peer
		
func _on_button_host_pressed() -> void:
		# Create server.
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT, MAX_CLIENTS)
	multiplayer.multiplayer_peer = peer

func on_connection(id):
	print("connectedstuff")
	#add_player.rpc(multiplayer.get_unique_id())


func on_disconnection(id):
	print("disconnected stuff")
