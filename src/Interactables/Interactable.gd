extends Area2D

# Treat this as an abstract class, interactables should extend from this
class_name Interactable

export(Level.LevelColor) var color setget set_color

var outline_shader: ShaderMaterial = preload("res://Resources/outline.tres")
var sprite: Node2D = null

var is_interactable = true

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
	if is_interactable:
		print("interacted with %s" % name)
	else: 
		print("could not interact with %s" % name)

func _on_area_entered(area: Area2D) -> void:
	if is_interactable:
		sprite.material = outline_shader

func _on_area_exited(area: Area2D) -> void:
	sprite.material = null

func update_color(background_color: int) -> void:
	if background_color == color:
		is_interactable = false
		sprite.material = null
	else:
		is_interactable = true
	
# This function is only called in the editor
func set_color(col: int) -> void:
	color = col
	if has_node("Sprite"):
		var sprite: Sprite = get_node("Sprite")
		get_node("Sprite").frame = color % sprite.hframes
