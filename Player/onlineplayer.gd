extends CharacterBody3D



func _physics_process(delta: float) -> void:
	var input_dir := Vector3.ZERO

	if Input.is_action_pressed("up"):
		input_dir.x = 1
	if Input.is_action_pressed("down"):
		input_dir.x = -1
	if Input.is_action_pressed("left"):
		input_dir.z = 1
	if Input.is_action_pressed("right"):
		input_dir.z = -1

	if input_dir != Vector3.ZERO:
		input_dir = input_dir.normalized()
		
	velocity = 10 *input_dir
	move_and_slide()
