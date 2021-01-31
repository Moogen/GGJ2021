tool
extends Interactable

export var on = false
export(NodePath) var player
export(NodePath) var crates_group

onready var sprite_flipped: Sprite = $SpriteInactive

# Called when the node enters the scene tree for the first time.
func _ready():
	if on:
		_flip_gravity()
	pass # Replace with function body.

func interact(): 
	#This will assume there is a parent named "Map#"
	if is_interactable:
		_flip_gravity()
		on = !on
	#TODO: also change the sprite for the flip of the lever
	
func _flip_gravity() -> void:
	get_node(player).flip_gravity()
	for crate in get_node(crates_group).get_children():
		crate.flip_gravity()
	if on:
		sprite.frame = (sprite.frame + sprite.hframes) % (sprite.hframes * sprite.vframes)
		
func update_color(background_color: int) -> void:
	if color == Level.LevelColor.BLACK:
		return
		
	if background_color == color:
		is_interactable = false
		sprite.material = null
		sprite_flipped.visible = true
		sprite.visible = false
	else:
		is_interactable = true
		sprite_flipped.visible = false
		sprite.visible = true
