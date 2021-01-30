extends Area2D

# Treat this as an abstract class, interactables should extend from this
class_name Interactable

var sprite: Node2D = null
var outline_shader: ShaderMaterial = preload("res://Resources/outline.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered", self, "_on_area_entered")
	connect("area_exited", self, "_on_area_exited")
	_check_for_sprite()
	pass # Replace with function body.
	
func _check_for_sprite() -> void:
	if has_node("Sprite"):
		sprite = get_node("Sprite")
	elif has_node("AnimatedSprite"):
		sprite = get_node("AnimatedSprite")
	else:
		assert(false, "Please add a sprite to the interactable")
	
	sprite.material = null

# Virtual function, override this in child scripts
func interact():
	print("interacted with %s" % name)

func _on_area_entered(area: Area2D) -> void:
	sprite.material = outline_shader
	pass

func _on_area_exited(area: Area2D) -> void:
	sprite.material = null
	pass