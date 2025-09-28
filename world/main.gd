extends Node3D


@export var player_scene: PackedScene

var id = 0

func _ready() -> void:
	print(self.get_path()) 
	print(multiplayer.get_unique_id())

	#add_player(multiplayer.get_unique_id())
	add_player.rpc_id(1,multiplayer.get_unique_id())

@rpc("any_peer","call_local")
func add_player(id):
	print(self.get_path()) 
	print(name)
	print(id)
	var new_player = player_scene.instantiate()
	new_player.name = str(id)
	$Players.add_child(new_player)
