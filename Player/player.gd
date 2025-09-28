extends RigidBody3D

@export var force_strength: float = 20.0
@export var torque_strength: float = 5.0
@export var target_path: NodePath  # assign your Camera3D here

var camera: Camera3D

func _ready() -> void:
	camera = get_node(target_path)

func _physics_process(delta: float) -> void:
	var input_dir := Vector3.ZERO

	if Input.is_action_pressed("up"):
		input_dir.z += 1
	if Input.is_action_pressed("down"):
		input_dir.z -= 1
	if Input.is_action_pressed("left"):
		input_dir.x += 1
	if Input.is_action_pressed("right"):
		input_dir.x -= 1

	if input_dir != Vector3.ZERO:
		input_dir = input_dir.normalized()

		# Camera-relative movement
		var forward = -camera.global_transform.basis.z
		var right = camera.global_transform.basis.x
		var move_dir = (forward * input_dir.z + right * input_dir.x).normalized()

		# Apply force
		apply_central_force(move_dir * force_strength)

		# Optional torque for rolling
		var torque = Vector3(input_dir.z, 0, -input_dir.x) * torque_strength
		apply_torque(Vector3(input_dir.z, 0, -input_dir.x) * torque_strength)
