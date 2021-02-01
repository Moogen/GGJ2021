extends Node

onready var animation = $AnimationPlayer
onready var viewport1 = $HBoxContainer/ViewportContainer/Viewport
onready var viewport2 = $HBoxContainer/ViewportContainer2/Viewport2
onready var camera1 = $HBoxContainer/ViewportContainer/Viewport/Camera
onready var camera2 = $HBoxContainer/ViewportContainer2/Viewport2/Camera2
onready var level: Node = null

var levels = [
	"res://Levels/Level1.tscn",
	"res://Levels/Level2.tscn",
	"res://Levels/Level3.tscn",
	"res://Levels/Level4.tscn",
	"res://Levels/Level7.tscn",
	"res://Levels/VictoryScreen.tscn"
	# "res://Levels/Sandbox/Sandbox.tscn",
	# "res://Levels/Sandbox/Sandbox2.tscn"
]

var curr_level_index = 0
var is_loading_level = false
signal go_through_door

# Called when the node enters the scene tree for the first time.
func _ready():
	viewport2.world_2d = viewport1.world_2d
	restart_level()
	pass # Replace with function body.
	
func _process(delta):
	if Input.is_action_just_pressed("restart"):
		restart_level()
	if Input.is_action_just_pressed("ui_accept"):
		load_next_level()

func load_next_level():
	curr_level_index += 1
	_handle_level_load()
	
func restart_level():
	_handle_level_load()
	
func _handle_level_load():
	if is_loading_level:
		return
		
	is_loading_level = true
	animation.play("transition_out")
	yield(animation, "animation_finished")
	
	if level:
		level.queue_free()
	level = load(levels[curr_level_index]).instance()
	level.connect("player_died", self, "restart_level")
	level.connect("door_entered", self, "load_next_level")

	viewport1.add_child(level)
	camera1.target = level.get_node("Player1")
	camera2.target = level.get_node("Player2")
	
	animation.play("transition_in")
	is_loading_level = false
