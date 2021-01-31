tool
extends Interactable

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interact(): 
	if is_interactable:
		var level: Level = get_parent()
		level.set_color(color)
		if has_node("SpriteInactive"):
			get_node("SpriteInactive").visible = true
			sprite.visible = false
			get_node("SpriteInactive").frame = color % sprite.hframes
