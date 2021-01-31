extends Node

onready var viewport1 = $HBoxContainer/ViewportContainer/Viewport
onready var viewport2 = $HBoxContainer/ViewportContainer2/Viewport2
onready var camera1 = $HBoxContainer/ViewportContainer/Viewport/Camera
onready var camera2 = $HBoxContainer/ViewportContainer2/Viewport2/Camera2
onready var level: Node = viewport1.get_node("Level")

var levels = []
var curr_level_index = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	viewport2.world_2d = viewport1.world_2d
	camera1.target = level.get_node("Player1")
	camera2.target = level.get_node("Player2")
	pass # Replace with function body.

func load_next_level():
	curr_level_index += 1
	level.connect("player_died", self, "restart_level")
	pass
	
func restart_level():
	pass
