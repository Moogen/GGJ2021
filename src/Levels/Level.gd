extends Node

class_name Level

signal player_died
signal door_entered

enum LevelColor {RED, GREEN, BLUE, BLACK}

var color: int = 0

onready var background_tiles: TileMap = $BackgroundTiles

var player_entered_door = false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Player1").connect("died", self, "_on_player_died")
	get_node("Player2").connect("died", self, "_on_player_died")
	get_node("EndDoor1").connect("go_through_door", self, "_on_door_entered")
	get_node("EndDoor2").connect("go_through_door", self, "_on_door_entered")
	set_color(background_tiles.color) 
	pass # Replace with function body.


func set_color(color: int):
	background_tiles.set_color(color)
	
	if has_node("ArtTiles"):
		var art_tiles = get_node("ArtTiles")
		art_tiles.set_color(color)
	
	var interactables = get_tree().get_nodes_in_group("colorful")
	for interactable in interactables:
		if interactable.has_method("update_color"):
			interactable.update_color(color)

func _on_player_died() -> void:
	emit_signal("player_died")

func _on_door_entered() -> void:
	if player_entered_door:
		return
	player_entered_door = true
	for player in get_tree().get_nodes_in_group("player"):
		if player.has_method("play_enter_door"):
			player.play_enter_door()
	yield(get_tree().create_timer(1), "timeout")
	emit_signal("door_entered")
