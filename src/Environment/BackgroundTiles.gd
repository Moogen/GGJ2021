extends TileMap

var blue_texture: Texture = preload("res://Assets/Sprites/Art Assets/Environment/wall texture1.png")
var green_texture: Texture = preload("res://Assets/Sprites/Art Assets/Environment/wall texture2.png")

var curr_texture: Texture = blue_texture


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if curr_texture == blue_texture:
			curr_texture = green_texture
		else:
			curr_texture = blue_texture
		tile_set.tile_set_texture(0, curr_texture)
