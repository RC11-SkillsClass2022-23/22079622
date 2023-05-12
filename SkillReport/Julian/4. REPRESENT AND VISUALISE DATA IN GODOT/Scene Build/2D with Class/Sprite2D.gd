extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_image(path):
	var custom_texture = load_png(path)
	if custom_texture != null:
		set_texture(custom_texture)
		
func load_png(file):
	var png_file = FileAccess.open(file,FileAccess.READ)
	var img = Image.new()
	var err = img.load(file)
	if err != OK:
		print("image load error")
	var newTexture = ImageTexture.create_from_image(img)
	texture = newTexture
	return texture
