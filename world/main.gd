extends Node3D


@export var player_scene: PackedScene

var id = 0

func _ready() -> void:
	add_player(multiplayer.get_unique_id())



func add_player(id):
	var new_player = player_scene.instantiate()
	new_player.name = str(id)
	$Players.add_child(new_player)
