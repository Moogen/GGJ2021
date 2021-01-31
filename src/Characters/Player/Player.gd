extends KinematicBody2D

enum PlayerNumber {One, Two}

signal died

export(PlayerNumber) var player_num

export var speed: float = 128
export var jump_height: float = 32
export var time_to_jump_apex: float = 0.3

onready var animated_sprite: AnimatedSprite = $Graphics/AnimatedSprite
onready var interactable_detector: Area2D = $InteractableDetector

class_name Player

"""
Input Mapping Variables
"""
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
Physics and Animation Variables
"""
enum GravityOrientation {Up = -1, Down = 1}
var gravity = 0 
var jump_force = 0
var velocity := Vector2()

enum AnimationState {
	Idle,
	RunningLeft,
	RunningRight,
	JumpingUp,
	JumpingDown,
	Interacting,
	Landing,
	Climbing
}

var animation_state = AnimationState.Idle

signal velocity_up
signal velocity_down

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

"""
Lifecycle Methods
"""
func _ready() -> void:
	_init_player_config()
	set_gravity(GravityOrientation.Down)
	animated_sprite.connect("animation_finished", self, "test")
	# connect("velocity_up", self, "")

func test():
	print("test")
	
func _physics_process(delta: float) -> void:
	_handle_input()
	# _handle_jump_sequence(false)
	_handle_movement(delta)
	_handle_animation()
	# if Input.is_action_just_pressed(input_dict["interact"]):
	# 	_check_for_interactables()

"""
Private Methods
"""
func _init_player_config() -> void:
	"""
	Initializes the Animation SpriteFrames and Input Mapping Set depending on if this script is attached to Player One or Two
	"""
	var sprite_frames
	if player_num == PlayerNumber.One:
		sprite_frames = load("res://Characters/Player/Player1_Spriteframe.tres")
		input_dict = input_dict_player_1
	elif player_num == PlayerNumber.Two:
		sprite_frames = load("res://Characters/Player/Player2_Spriteframe.tres")
		input_dict = input_dict_player_2
	animated_sprite.frames = sprite_frames
	animated_sprite.play("idle")
	
func _handle_input() -> void:
	# Animation State Juggling is a real pain in my rear
	if Input.is_action_just_pressed(input_dict["left"]):
		print("Pressed Left")
		if animation_state == AnimationState.Idle:
			animation_state = AnimationState.RunningLeft
		print(animation_state)
		print("\n")
	elif Input.is_action_just_released(input_dict["left"]):
		print("Released Left")
		if animation_state == AnimationState.RunningLeft:
			animation_state = AnimationState.Idle
		print(animation_state)
		print("\n")
	elif Input.is_action_just_pressed(input_dict["right"]):
		print("Pressed Right")
		if animation_state == AnimationState.Idle:
			animation_state = AnimationState.RunningRight
		print(animation_state)
		print("\n")
	elif Input.is_action_just_released(input_dict["right"]):
		print("Released Right")
		if animation_state == AnimationState.RunningRight:
			animation_state = AnimationState.Idle
		print(animation_state)
		print("\n")
	elif Input.is_action_just_pressed(input_dict["up"]):
		print("Pressed Up")
		# TODO: handle climbing here as well
		
		print(animation_state)
		print("\n")
		
func _handle_jump_sequence(init: bool) -> void:
	if init:
		animation_state["jumping"] = true
		
	var is_on_floor = (gravity > 0 and is_on_floor()) or (gravity < 0 and is_on_ceiling())

	if velocity.y > 0:
		animation_state["jumping_up"] = true
		animation_state["jumping_down"] = false
	elif velocity.y < 0:
		animation_state["jumping_up"] = false
		animation_state["jumping_down"] = true
	
	if not is_on_floor:
		animation_state["landing"] = false	
	else:
		if animation_state["jumping"] and not animation_state["landing"]:
			animation_state["jumping"] = false
			animation_state["jumping_down"] = false
			animation_state["landing"] = true
		else:
			animation_state["landing"] = false
			animation_state["idle"] = true

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

func _handle_animation() -> void:
	var curr_anim = animated_sprite.animation
	var playing = animated_sprite.playing
	
	## TODO check out animation signals
	if animation_state == AnimationState.Idle:
		animated_sprite.play("idle")
	elif animation_state == AnimationState.RunningLeft:
		animated_sprite.play("run")
		animated_sprite.flip_h = false
	elif animation_state == AnimationState.RunningRight:
		animated_sprite.play("run")
		animated_sprite.flip_h = true
	elif animation_state == AnimationState.JumpingUp:
		animated_sprite.play("jump_up")
	elif animation_state == AnimationState.JumpingDown:
		animated_sprite.play("jump_down")
	elif animation_state == AnimationState.Landing:
		animated_sprite.play("jump_landing")
	elif animation_state == AnimationState.Climbing:
		animated_sprite.play("climb")
	elif animation_state == AnimationState.Interacting:
		animated_sprite.play("interact")
		
func _check_for_interactables() -> void:
	var interactables = interactable_detector.get_overlapping_areas()
	for interactable in interactables:
		if interactable is Interactable:
			interactable.interact()

