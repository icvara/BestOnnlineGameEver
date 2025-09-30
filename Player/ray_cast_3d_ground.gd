extends RayCast3D


#func _ready():
	## Lock the raycast rotation so it always points down
	#rotation = Vector3.ZERO
	#position = Vector3.ZERO
func _physics_process(delta):
	position = get_parent().get_node("Player").global_position
	get_parent().get_node("Label3D_name").position = get_parent().get_node("Player").global_position + Vector3(0,1,0)
