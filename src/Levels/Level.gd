extends Node

export var color = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_color(color: int):
	#TODO: Modify background color
	#TODO: Modify interactability and sprites of children
	for child in get_children(): #should look at all "maps" on level
		if child.has_method("update_color"): #catch any colored objects on level level
			child.update_color(color)
		for sub_child in child.find_node("Interactables"): #find interactables node within the map
			if sub_child.has_method("update_color"): sub_child.update_color(color)
		for sub_child in child.find_node("Environment"):
			if sub_child.has_method("update_color"): sub_child.update_color(color)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
