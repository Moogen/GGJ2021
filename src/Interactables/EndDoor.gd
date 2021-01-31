extends Interactable

enum state {
	open = 0
	closed = 1
	start = 2
}

signal open_door
signal close_door
signal go_through_door

var isOpen = false

export(NodePath) var OtherDoor
export(state) var door_state setget set_state

# Called when the node enters the scene tree for the first time.
func _ready():
	_check_for_sprite()
	if has_node("Sprite"):
		var sprite: Sprite = get_node("Sprite")
		if sprite.frame != 2: #start door
			connect("open_door", get_node(OtherDoor), "_open")
			connect("close_door", get_node(OtherDoor), "_close")
	
func interact():
	if(isOpen and get_node(OtherDoor).isOpen):
		emit_signal("go_through_door")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _open():
	isOpen = true
	if has_node("Sprite"):
		var sprite: Sprite = get_node("Sprite")
		sprite.frame -=1
	
func _close():
	isOpen = false
	if has_node("Sprite"):
		var sprite: Sprite = get_node("Sprite")
		sprite.frame +=1

func _on_EndDoor_body_entered(body):
	emit_signal("open_door")
	
func _on_EndDoor_body_exited(body):
	emit_signal("close_door")
	
func set_state(state: int) -> void:
	if has_node("Sprite"):
		var sprite: Sprite = get_node("Sprite")
		sprite.frame = state % sprite.vframes


