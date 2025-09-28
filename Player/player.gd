extends RigidBody3D

@export var rotation_speed := 0.005
@export var camera_distance := 5.0
@export var camera_height := 2.0
@export var move_force := 2.0  # Adjust to taste

var yaw := 0.0
var pitch := 0.0

var camera_pivot: Node3D = null
var camera: Camera3D = null

func _ready():
	# Set initial camera offset
	camera_pivot = %CameraPivot
	camera = %CameraPivot/Camera
	camera.position = Vector3(0, 0, camera_distance)
	camera_pivot.position = Vector3(0, camera_height, 0)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # Capture mouse


func _physics_process(delta):
	var input_vector := Vector3.ZERO
		# Update camera pivot to follow ball position + height
	camera_pivot.global_position = global_position + Vector3(0, camera_height, 0)
	# Get input
	if Input.is_action_pressed("up"):
		input_vector.z -= 1
	if Input.is_action_pressed("down"):
		input_vector.z += 1
	if Input.is_action_pressed("left"):
		input_vector.x -= 1
	if Input.is_action_pressed("right"):
		input_vector.x += 1
	
	if input_vector != Vector3.ZERO:
		input_vector = input_vector.normalized()
		
		# Rotate input to match camera orientation
		var cam_yaw :float= camera_pivot.rotation.y
		var direction := input_vector.rotated(Vector3.UP, cam_yaw)
		
		# Apply force in the desired direction
		apply_torque_impulse(direction.cross(Vector3.UP) * move_force)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		# Rotate camera based on mouse movement
		yaw -= event.relative.x * rotation_speed
		pitch -= event.relative.y * rotation_speed
		
		# Clamp vertical rotation to avoid flipping
		pitch = clamp(pitch, -1.0, 1.2)
		
		# Apply rotation to pivot
		camera_pivot.rotation = Vector3(pitch, yaw, 0)
