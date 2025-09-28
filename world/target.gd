extends Area3D


func _on_body_entered(body: Node3D) -> void:
	$Label3D.show()
	pass # Replace with function body.
	await get_tree().create_timer(.2).timeout # waits for 1 second
	$Label3D.hide()
