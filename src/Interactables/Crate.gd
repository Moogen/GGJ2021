tool
extends KinematicBody2D

export(Level.LevelColor) var color setget set_color

onready var inactive_sprite: Sprite = $InactiveSprite
onready var player_collision: CollisionShape2D = $PlayerCollider/CollisionShape2D

var velocity := Vector2()
var is_active = true
var is_being_pushed = false
var can_be_pushed = true

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
	
func flip_gravity() -> void:
	gravity *= -1

func _on_PlayerDetector_body_entered(body: Node2D):
	print("%s detected player enter" % name)
	if can_be_pushed:
		is_being_pushed = true
	dir_x = sign(global_position.x - body.global_position.x)
	pass # Replace with function body.

func _on_PlayerDetector_body_exited(body: Node2D):
	print("%s detected player exit" % name)
	is_being_pushed = false
	pass # Replace with function body.
	
func _on_CrateDetector_body_entered(body: Node2D):
	if body == self:
		return
		
	print("%s detected crate enter" % name)
	if can_be_pushed && !is_being_pushed:
		is_being_pushed = true
		dir_x = sign(global_position.x - body.global_position.x)


func _on_CrateDetector_body_exited(body: Node2D):
	if body == self:
		return
	print("%s detected crate exit" % name)
	is_being_pushed = false
	pass # Replace with function body.

func update_color(background_color: int) -> void:
	if color == Level.LevelColor.BLACK:
		return
		
	if background_color == color:
		can_be_pushed = false
		inactive_sprite.visible = true
		player_collision.set_deferred("disabled", true)
	else:
		can_be_pushed = true
		inactive_sprite.visible = false
		player_collision.set_deferred("disabled", false)
		
# This function is only called in the editor
func set_color(col: int) -> void:
	color = col
	if has_node("Sprite"):
		var sprite: Sprite = get_node("Sprite")
		sprite.frame = color % sprite.hframes
	if has_node("InactiveSprite"):
		var sprite: Sprite = get_node("InactiveSprite")
		sprite.frame = color % sprite.hframes

