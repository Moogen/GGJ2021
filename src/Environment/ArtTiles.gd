tool
extends TileMap

export(Level.LevelColor) var color setget set_color

var blue_texture: Texture = preload("res://Assets/Sprites/Art Assets/Environment/wall_texture5.png")
var green_texture: Texture = preload("res://Assets/Sprites/Art Assets/Environment/wall_texture6.png")
var red_texture: Texture = preload("res://Assets/Sprites/Art Assets/Environment/wall_texture7.png")

var curr_texture: Texture = blue_texture

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
		
func set_color(col: int) -> void:
	color = col
	if color == Level.LevelColor.BLUE:
		curr_texture = blue_texture
	elif color == Level.LevelColor.GREEN:
		curr_texture = green_texture
	elif color == Level.LevelColor.RED:
		curr_texture = red_texture
	tile_set.tile_set_texture(0, curr_texture)
