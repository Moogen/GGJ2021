extends KinematicBody2D

export var speed: float = 128
export var jump_height: float = 32
export var time_to_jump_apex: float = 0.8

onready var graphics: Node2D = $Graphics

var gravity = 0 
var jump_force = 0
var velocity := Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	gravity = 2 * jump_height / pow(time_to_jump_apex, 2)
	jump_force = gravity * time_to_jump_apex
	pass # Replace with function body.

func _process(delta: float) -> void:
	var dir_x = 0
	if Input.is_action_pressed("left"):
		dir_x -= 1
	if Input.is_action_pressed("right"):
		dir_x += 1
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y += jump_force
	
	velocity.x = dir_x * speed
	velocity.y -= gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if is_on_floor():
		velocity.y = 0
