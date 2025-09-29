extends RigidBody3D


@export var move_force := 2.0  # Adjust to taste


@export var camera : Camera3D

var playername = "name"
var color = Color(1.0, 1.0, 1.0, 1.0)

var cam_yaw : float = 0


func _enter_tree() -> void:
	set_multiplayer_authority(get_parent().name.to_int(), true)
	$Label3D_name.text = playername
	$MeshInstance3D.mesh.material.albedo_color = color

func _ready() -> void:
	global_position.y = 10


func _physics_process(delta):
	if is_multiplayer_authority():
		var input_vector := Vector3.ZERO

		# Get input
		if Input.is_action_pressed("up"):
			input_vector.x -= 1
		if Input.is_action_pressed("down"):
			input_vector.x += 1
		if Input.is_action_pressed("left"):
			input_vector.z += 1
		if Input.is_action_pressed("right"):
			input_vector.z -= 1
		
		if input_vector != Vector3.ZERO:
			input_vector = input_vector.normalized()
			
			# Rotate input to match camera orientation
			#var cam_yaw :float= camera_pivot.rotation.y
			var direction := input_vector.rotated(Vector3.UP, cam_yaw)
			#var direction = Vector3(1,0,0)
			# Apply force in the desired direction
			#apply_torque_impulse(direction.cross(Vector3.UP) * move_force)
			apply_impulse(direction.cross(Vector3.UP) * move_force*delta)
