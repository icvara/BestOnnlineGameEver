extends Node3D

@export var target: Node3D
@export var camera_height :float = 2.0
@export var camera_distance :float = 5.0
@export var rotation_speed := 0.005



var yaw := 0.0
var pitch := 0.0

var camera_pivot: Node3D = null
var camera: Camera3D = null


func _ready():
	# Set initial camera offset
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # Capture mouse


func _process(delta: float) -> void:
	position = target.position + Vector3(0,camera_height,0)
	pass


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		# Rotate camera based on mouse movement
		yaw -= event.relative.x * rotation_speed
		pitch -= event.relative.y * rotation_speed
		
		# Clamp vertical rotation to avoid flipping
		pitch = clamp(pitch, -1.0, 1.2)
		
		# Apply rotation to pivot
		rotation = Vector3(pitch, yaw, 0)
		target.cam_yaw= yaw
		# Update camera pivot to follow ball position + height
	#camera_pivot.global_position = global_position + Vector3(0, camera_height, 0)
