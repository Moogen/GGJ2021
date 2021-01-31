extends KinematicBody2D

enum PlayerNumber {One, Two}

signal died

export(PlayerNumber) var player_num

export var speed: float = 128
export var jump_height: float = 32
export var time_to_jump_apex: float = 0.3

onready var animated_sprite: AnimatedSprite = $Graphics/AnimatedSprite
onready var graphics: Node2D = $Graphics
onready var interactable_detector: Area2D = $InteractableDetector

class_name Player

enum GravityOrientation {Up = -1, Down = 1}

var gravity = 0 
var jump_force = 0
var velocity := Vector2()
var input_dict := Dictionary()
const input_dict_player_1 = {
	"left": "ui_p1_left",
	"right": "ui_p1_right",
	"up": "ui_p1_up",
	"down": "ui_p1_down",
	"interact": "ui_p1_interact"
}

const input_dict_player_2 = {
	"left": "ui_p2_left",
	"right": "ui_p2_right",
	"up": "ui_p2_up",
	"down": "ui_p2_down",
	"interact": "ui_p2_interact"
}

"""
Public Methods
"""
func flip_gravity() -> void:
	gravity *= -1
	jump_force *= -1
	animated_sprite.flip_v = gravity < 0
	
func set_gravity(orientation: int) -> void:
	gravity = orientation * 2 * jump_height / pow(time_to_jump_apex, 2)
	jump_force = orientation * gravity * time_to_jump_apex

func kill() -> void:
	emit_signal("died")
	
func play_enter_door() -> void:
	set_physics_process(false)
	animated_sprite.play("door_enter")

"""
Lifecycle Methods
"""
func _ready() -> void:
	# Called when the node enters the scene tree for the first time.
	_init_player_config()
	set_gravity(GravityOrientation.Down)
	
func _physics_process(delta: float) -> void:
	_handle_movement(delta)
	_handle_animation(delta)
	if Input.is_action_just_pressed(input_dict["interact"]):
		_check_for_interactables()

"""
Private Methods
"""

func _init_player_config() -> void:
	var sprite_frames
	if player_num == PlayerNumber.One:
		sprite_frames = load("res://Characters/Player/Player1_Spriteframe.tres")
		input_dict = input_dict_player_1
	elif player_num == PlayerNumber.Two:
		sprite_frames = load("res://Characters/Player/Player2_Spriteframe.tres")
		input_dict = input_dict_player_2
	animated_sprite.frames = sprite_frames
	animated_sprite.play("idle")
	
func _handle_movement(delta: float) -> void:
	var is_on_floor = (gravity > 0 && is_on_floor()) || (gravity < 0 && is_on_ceiling())
	# TODO: need to handle up and down for climbing
	var dir_x = 0
	if Input.is_action_pressed(input_dict["left"]):
		dir_x -= 1
	if Input.is_action_pressed(input_dict["right"]):
		dir_x += 1
	if Input.is_action_pressed(input_dict["up"]) && is_on_floor:
		velocity.y = -jump_force
	
	velocity.x = dir_x * speed
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if is_on_floor():
		velocity.y = 0

func _handle_animation(delta: float) -> void:
	if Input.is_action_pressed(input_dict["left"]):
		animated_sprite.flip_h = false
		animated_sprite.play("run")
	elif Input.is_action_pressed(input_dict["right"]):
		animated_sprite.flip_h = true
		animated_sprite.play("run")
	elif Input.is_action_pressed(input_dict["up"]):
		# TODO: account for climbing as well
		animated_sprite.play("jump")
		pass
	elif Input.is_action_pressed(input_dict["down"]):
		# TODO
		pass
	elif Input.is_action_just_pressed(input_dict["interact"]):
		animated_sprite.play("interact")
		pass
	else:
		animated_sprite.play("idle")
	
func _check_for_interactables() -> void:
	var interactables = interactable_detector.get_overlapping_areas()
	for interactable in interactables:
		if interactable is Interactable:
			interactable.interact()

