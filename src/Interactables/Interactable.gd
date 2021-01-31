extends Area2D

# Treat this as an abstract class, interactables should extend from this
class_name Interactable

export(Level.LevelColor) var color setget set_color

var outline_shader: ShaderMaterial = preload("res://Resources/outline.tres")
var sprite: Sprite = null

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
	if color == Level.LevelColor.BLACK:
		return
		
	if background_color == color:
		is_interactable = false
		sprite.material = null
		if has_node("SpriteInactive"):
			get_node("SpriteInactive").visible = true
			sprite.visible = false
	else:
		is_interactable = true
		if has_node("SpriteInactive"):
			get_node("SpriteInactive").visible = false
			sprite.visible = true
	
# This function is only called in the editor
func set_color(col: int) -> void:
	color = col
	if has_node("Sprite"):
		var sprite: Sprite = get_node("Sprite")
		sprite.frame = color % sprite.hframes
	if has_node("SpriteInactive"):
		var sprite: Sprite = get_node("SpriteInactive")
		sprite.frame = color % sprite.hframes
