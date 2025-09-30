extends RayCast3D


func _ready():
	# Lock the raycast rotation so it always points down
	rotation = Vector3.ZERO
	position = Vector3.ZERO
func _physics_process(delta):
	rotation = Vector3.ZERO
