extends Camera3D

@export var target_path: NodePath
@export var follow_speed: float = 15.0
@export var offset: Vector3 = Vector3(0, 5, -5)

var target: Node3D

func _ready() -> void:
	target = get_node(target_path)

func _process(delta: float) -> void:
	if target:
		var desired_pos = target.global_transform.origin + offset
		global_transform.origin = global_transform.origin.lerp(desired_pos, follow_speed * delta)
		look_at(target.global_transform.origin, Vector3.UP)
