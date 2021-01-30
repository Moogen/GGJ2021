extends Interactable

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interact(): 
	#This will assume there is a parent named "Level#"
	if is_interactable:
		find_parent("Level*").set_color(my_color)
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
