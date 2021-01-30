extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func is_top() -> bool:
	return name=="Level1"

func flip_gravity():
	for child in get_children():
		if (child is Player) or (child is Object): #TODO - replace with whatever the box class is called
			child.gravity = child.gravity*-1
			child.jump_force = child.jump_force*-1

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
