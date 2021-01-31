extends Button

export var next_scene: String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", self, "_button_pressed")

func _button_pressed():
	if (next_scene == ""):
		return
	get_tree().change_scene(next_scene)
