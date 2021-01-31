tool
extends Interactable

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interact(): 
	if is_interactable:
		var level: Level = get_tree().current_scene
		level.set_color(color)
