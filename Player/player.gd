extends RigidBody3D


@export var move_force := 60.0  # Adjust to taste
@export var max_speed := 30.0  # tweak as needed 
@export var jump_force := 80.0  # tweak this for desired jump height


@export var camera : Camera3D
var playername = "name"
var color = Color(1.0, 1.0, 1.0, 1.0)
var color_r = 0.0
var color_g = 0.0
var color_b = 0.0


var cam_yaw : float = 0


func _enter_tree() -> void:
	set_multiplayer_authority(get_parent().name.to_int(), true)
	
@rpc("any_peer","call_local")
func set_player_skin(nametag,playercolor):
	#if is_multiplayer_authority():
	playername = nametag
	color =  playercolor
	color_r =  playercolor.r
	color_g =  playercolor.g
	color_b =  playercolor.b
		#$MeshInstance3D.material = $MeshInstance3D.mesh.material.duplicate()
	if $MeshInstance3D.material_override == null:
			$MeshInstance3D.material_override = $MeshInstance3D.mesh.material.duplicate()


	# Change the unique instance
	$MeshInstance3D.material_override.albedo_color = color
	$Label3D_name.text = nametag

func _ready() -> void:
	#print(str(get_parent().name.to_int()) + "-" + str(is_multiplayer_authority()))
	#print(color)
	global_position.y = 10
	if multiplayer.is_server():
		color = GlobalInfo.player_info[get_parent().name.to_int()]["col"]
	#set_player_skin.rpc(playername,Color(color_r,color_g,color_b))
	#print(get_parent().playername)

@rpc("any_peer", "call_local")
func network_update():
	#if is_multiplayer_authority():
		print("---------------------")
		print(multiplayer.get_unique_id())
		print(get_parent().name.to_int())
		print(playername)
		print(color)
		#color = Color(0.0, 1.0, 0.0, 1.0)
		if $MeshInstance3D.material_override == null:
				$MeshInstance3D.material_override = $MeshInstance3D.mesh.material.duplicate()
		$MeshInstance3D.material_override.albedo_color = color
		$Label3D_name.text = playername

func is_on_ground() -> bool:
	return $RayCast3D_ground.is_colliding()

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
		if Input.is_action_just_pressed("space"):
			network_update.rpc()
		
				# Jump
		if Input.is_action_just_pressed("space") and is_on_ground():
		#linear_velocity.y == 0:
			apply_impulse(Vector3.UP * jump_force)
		
		if input_vector != Vector3.ZERO:
			input_vector = input_vector.normalized()
			print(linear_velocity)
			# Rotate input to match camera orientation
			#var cam_yaw :float= camera_pivot.rotation.y
			var direction := input_vector.rotated(Vector3.UP, cam_yaw)
			#var direction = Vector3(1,0,0)
			# Apply force in the desired direction
			#apply_torque_impulse(direction.cross(Vector3.UP) * move_force)
			apply_impulse(direction.cross(Vector3.UP) * move_force*delta)
			# 🔹 Cap velocity
		if linear_velocity.length() > max_speed:
			linear_velocity = linear_velocity.normalized() * max_speed
