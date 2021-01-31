extends KinematicBody2D

enum PlayerNumber {One, Two}

export(PlayerNumber) var player_num

export var speed: float = 256
export var jump_height: float = 128
export var time_to_jump_apex: float = 0.4

onready var animated_sprite: AnimatedSprite = $Graphics/AnimatedSprite
onready var graphics: Node2D = $Graphics
onready var interactable_detector: Area2D = $InteractableDetector

class_name Player

var gravity = 0 
var jump_force = 0
var velocity := Vector2()
var input_dict := Dictionary()
const input_dict_player_1 = {
	"left": "ui_p1_left",
	"right": "ui_p1_right",
	"up": "ui_p1_right",
	"down": "ui_p1_down",
	"interact": "ui_p1_interact",
	"jump": "ui_p1_jump"
}

const input_dict_player_2 = {
	"left": "ui_p2_left",
	"right": "ui_p2_right",
	"up": "ui_p2_right",
	"down": "ui_p2_down",
	"interact": "ui_p2_interact",
	"jump": "ui_p2_jump"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	_init_player_config()
	gravity = 2 * jump_height / pow(time_to_jump_apex, 2)
	jump_force = gravity * time_to_jump_apex
	
func _physics_process(delta: float) -> void:
	_handle_movement(delta)
	_handle_animation(delta)
	if Input.is_action_just_pressed(input_dict["interact"]):
		_check_for_interactables()
	
func _handle_movement(delta: float) -> void:
	# TODO: need to handle up and down for climbing
	var dir_x = 0
	if Input.is_action_pressed(input_dict["left"]):
		dir_x -= 1
	if Input.is_action_pressed(input_dict["right"]):
		dir_x += 1
	if Input.is_action_pressed(input_dict["jump"]) && is_on_floor():
		velocity.y = -jump_force
	
	velocity.x = dir_x * speed
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if is_on_floor():
		velocity.y = 0

func _handle_animation(delta: float) -> void:
	if Input.is_action_pressed(input_dict["left"]) or Input.is_action_pressed(input_dict["right"]):
		animated_sprite.play("run")

func kill() -> void:
	print("player ded")
	print("oh no orz :(")

func _check_for_interactables() -> void:
	var interactables = interactable_detector.get_overlapping_areas()
	for interactable in interactables:
		if interactable is Interactable:
			interactable.interact()

func _init_player_config() -> void:
	var sprite_frames
	if player_num == PlayerNumber.One:
		sprite_frames = load("Characters/Player/Player1_Spriteframes.tres")
		input_dict = input_dict_player_1
	elif player_num == PlayerNumber.Two:
		sprite_frames = load("Characters/Player/Player2_Spriteframes.tres")
		input_dict = input_dict_player_2
	animated_sprite.frames = sprite_frames
	# The following line is probably unnecessary?
	# Need to define a default animation though, so we'll see
	# animated_sprite.play("idle")
