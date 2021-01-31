extends Area2D

class_name Ladder

var color = Level.LevelColor.BLACK
onready var active_sprite: Sprite = $Sprite
onready var inactive_sprite: Sprite = $InactiveSprite
var outline_shader: ShaderMaterial = preload("res://Resources/outline.tres")

func init_color(col: int) -> void:
	# Should be called within the _ready function of LadderGroup
	color = col

func update_color(col: int) -> void:
	if col == color:
		# need to do signal emission here
		active_sprite.visible = false
		inactive_sprite.visible = true
	else:
		active_sprite.visible = true
		inactive_sprite.visible = false

func toggle_outline(on: bool) -> void:
	if not active_sprite.visible:
		return
	if on:
		active_sprite.material = outline_shader
	else:
		active_sprite.matieral = null

func update_sprites(col: int) -> void:
	if has_node("Sprite"):
		var sprite: Sprite = get_node("Sprite")
		sprite.frame = col % sprite.hframes
	if has_node("InactiveSprite"):
		var sprite: Sprite = get_node("InactiveSprite")
		sprite.frame = col % sprite.hframes
