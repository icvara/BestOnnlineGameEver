extends Control


var isConnected = false




func _on_button_quit_pressed() -> void:
	get_tree().quit()


func _on_button_play_pressed() -> void:
	if isConnected:
		
