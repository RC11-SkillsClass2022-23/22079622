extends Node3D

const RAY_LENGTH = 1000.0

@onready var objectClass = preload("res://object.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = FileAccess.open("res://goodObjects.json", FileAccess.READ)
	var contents = file.get_as_text()
	var objectDict = JSON.parse_string(contents)
	file.close()
	# print something from the dictionnary for testing.
	for o in objectDict:
		var n = o['name']
		var f = o['file']
		var loc = o['location']
		print(loc)
		var object = objectClass.instantiate()
		object.initialise('res://' + f, n)
		add_child(object)
		object.transform.origin = Vector3(loc[0]/100, loc[1]/100, loc[2]/100)
		object.startedRotating.connect(_on_clicked)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_clicked(object):
	print(object.name, " was pressed")

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
			var object = result['collider'].get_parent().get_parent().get_parent()
			object.click()
