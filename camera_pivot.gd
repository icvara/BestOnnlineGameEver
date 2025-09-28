extends Node3D

@export var rotation_speed := 0.005
@export var camera_distance := 5.0
@export var camera_height := 2.0

var yaw := 0.0
var pitch := 0.0
@onready var camera := $Camera

func _ready():
	camera.position = Vector3(0, 0, camera_distance)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		yaw -= event.relative.x * rotation_speed
		pitch -= event.relative.y * rotation_speed
		pitch = clamp(pitch, -1.0, 1.2)
		rotation = Vector3(pitch, yaw, 0)

func _process(delta):
	# Follow the ball position
	var ball = get_parent().get_node_or_null("Ball")  # adjust path if needed
	if ball:
		global_position = ball.global_position + Vector3(0, camera_height, 0)
