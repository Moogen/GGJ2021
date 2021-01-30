extends Interactable

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interact(): 
	#This will assume there is a parent named "Map#"
	if is_interactable:
		if (find_parent("Map*").is_top()):
			.find_parent("Level*").flip_gravity2()
		else:
			.find_parent("Level*").flip_gravity1()
	#TODO: also change the sprite for the flip of the lever
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
