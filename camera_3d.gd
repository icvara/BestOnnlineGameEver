#extends Camera3D
#
#@export var target_path: NodePath
#@export var follow_speed: float = 5.0
#@export var offset: Vector3 = Vector3(5, 5, -5)
#
#var target: Node3D
#
#func _ready() -> void:
	#target = get_node(target_path)
#
#func _process(delta: float) -> void:
	#if not target:
		#return
	#if target:
		#var desired_pos = target.global_transform.origin + offset
		#var target_pos = target.global_transform.origin
		#var desired_basis = Transform3D().looking_at(target_pos - global_transform.origin, Vector3.UP).basis
		#global_transform.basis = global_transform.basis.slerp(desired_basis, 1.0 - exp(-follow_speed * delta))
		##global_transform.origin = global_transform.origin.lerp(desired_pos, 1.0 - exp(-follow_speed * delta))
		##look_at(target.global_transform.origin, Vector3.UP)
extends Camera3D

@export var target_path: NodePath
@export var distance: float = 6.0   # how far behind the ball
@export var height: float = 3.0     # vertical offset
@export var sensitivity: float = 0.005

var target: Node3D
var yaw: float = 0.0

func _ready() -> void:
	target = get_node(target_path)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		yaw -= event.relative.x * sensitivity

func _physics_process(delta: float) -> void:
	if not target:
		return

	# Calculate simple offset behind the ball
	var offset = Vector3(sin(yaw) * distance, height, cos(yaw) * distance)

	# Move camera to follow
	global_position = target.global_position + offset

	# Look at the ball
	look_at(target.global_position, Vector3.UP)
