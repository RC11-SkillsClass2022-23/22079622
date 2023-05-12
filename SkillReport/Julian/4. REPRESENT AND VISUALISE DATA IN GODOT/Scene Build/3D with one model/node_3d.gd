extends Node3D

const RAY_LENGTH = 1000.0

# Called when the node enters the scene tree for the first time.
func _ready():
	var mosque = preload("res://ancient_tap.glb").instantiate()
	add_child(mosque)
	for _i in mosque.get_children():
		if _i.get_class() == "MeshInstance3D":
			print('found a mesh')
			_i.create_trimesh_collision()
			mosque.input_event.connect(_on_mesh_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_mesh_pressed(viewport: Object, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		print('pressed')

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		var camera3d = $Camera3D
		var from = camera3d.project_ray_origin(event.position)
		var to = from + camera3d.project_ray_normal(event.position) * RAY_LENGTH
		var worldspace = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(from, to)
		query.exclude = [self]
		var result = worldspace.intersect_ray(query)
		if result != {}:
			print(result)
			var object = result['collider'].get_parent()
			object.queue_free()

