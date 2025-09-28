extends RigidBody3D

@export var speed = 100
@export var force_strength: float = 20.0
@export var torque_strength: float = 5.0


func _physics_process(delta: float) -> void:
	var input_dir := Vector3.ZERO

	# WASD / Arrow input
	if Input.is_action_pressed("up"):
		input_dir.z -= 1
	if Input.is_action_pressed("down"):
		input_dir.z += 1
	if Input.is_action_pressed("left"):
		input_dir.x -= 1
	if Input.is_action_pressed("right"):
		input_dir.x += 1
	input_dir = input_dir.normalized()

	if input_dir != Vector3.ZERO:
		# Apply force to push the sphere
		apply_central_force(input_dir * force_strength)

	# Optional: make it roll more naturally by applying torque
		var torque = Vector3(input_dir.z, 0, -input_dir.x) * torque_strength
		apply_torque(torque)
