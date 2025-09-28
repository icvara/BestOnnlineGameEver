extends CharacterBody3D

@export var speed = 100



func _process(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = Vector3(input_direction.x,0,input_direction.y) * speed * delta



func _physics_process(delta: float) -> void:

	move_and_slide()
