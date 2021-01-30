extends TileMap

var blue_texture: Texture = preload("res://Assets/Sprites/Art Assets/Environment/wall texture1.png")
var green_texture: Texture = preload("res://Assets/Sprites/Art Assets/Environment/wall texture2.png")
var red_texture: Texture = preload("res://Assets/Sprites/Art Assets/Environment/wall texture3.png")

var curr_texture: Texture = blue_texture


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
		
func set_color(color: int) -> void:
	if color == Level.LevelColor.BLUE:
		curr_texture = blue_texture
	elif color == Level.LevelColor.GREEN:
		curr_texture = green_texture
	elif color == Level.LevelColor.RED:
		curr_texture = red_texture
	tile_set.tile_set_texture(0, curr_texture)
