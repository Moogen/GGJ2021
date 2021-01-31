extends Node

class_name Level

enum LevelColor {RED, GREEN, BLUE}

var color: int = 0

onready var background_tiles: TileMap = $BackgroundTiles

# Called when the node enters the scene tree for the first time.
func _ready():
	set_color(background_tiles.color)
	pass # Replace with function body.


func set_color(color: int):
	background_tiles.set_color(color)
	var interactables = get_tree().get_nodes_in_group("interactables")
	for interactable in interactables:
		interactable.update_color(color)
	var obstacles = get_tree().get_nodes_in_group("obstacles")
	for obstacle in obstacles:
		obstacle.update_color(color)
	
