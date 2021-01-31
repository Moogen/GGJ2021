extends Node

class_name Level

signal player_died

enum LevelColor {RED, GREEN, BLUE, BLACK}

var color: int = 0

onready var background_tiles: TileMap = $BackgroundTiles

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Player1").connect("died", self, "_on_player_died")
	get_node("Player2").connect("died", self, "_on_player_died")
	set_color(background_tiles.color) 
	pass # Replace with function body.


func set_color(color: int):
	background_tiles.set_color(color)
	var interactables = get_tree().get_nodes_in_group("colorful")
	for interactable in interactables:
		if interactable.has_method("update_color"):
			interactable.update_color(color)

func _on_player_died() -> void:
	emit_signal("player_died")
