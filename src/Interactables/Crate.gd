extends KinematicBody2D

var velocity := Vector2()
var is_active = true
var is_being_pushed = false

var speed = 64
var gravity = 256
var dir_x = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if is_being_pushed:
		velocity.x = speed * dir_x
	else:
		velocity.x *= 0.8
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_PlayerDetector_body_entered(body: Node2D):
	is_being_pushed = true
	dir_x = sign(global_position.x - body.global_position.x)
	pass # Replace with function body.


func _on_PlayerDetector_body_exited(body: Node2D):
	is_being_pushed = false
	pass # Replace with function body.
