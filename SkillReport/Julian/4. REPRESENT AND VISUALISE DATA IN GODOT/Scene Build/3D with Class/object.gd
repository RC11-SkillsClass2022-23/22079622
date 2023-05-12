extends Node3D

var rotating = false
signal startedRotating(extraInfo)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if rotating:
		self.rotate_y(0.01)

func click():
	rotating = !rotating
	if rotating:
		startedRotating.emit(self)

func initialise(path, n):
	name = n
	var object = load(path).instantiate()
	add_child(object)
	for _i in object.get_children():
		if _i.get_class() == "MeshInstance3D":
			_i.create_trimesh_collision()
