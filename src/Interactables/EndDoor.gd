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

var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	_check_for_sprite()
	if has_node("Sprite"):
		var sprite: Sprite = get_node("Sprite")
		if sprite.frame != 2: #start door
			connect("open_door", get_node(OtherDoor), "_open")
			connect("close_door", get_node(OtherDoor), "_close")
	
func interact():
	pass
#	if(isOpen and get_node(OtherDoor).isOpen):
#		if player && player.has_method("play_enter_door"):
#			player.play_enter_door()
#			yield(get_tree().create_timer(2), "timeout")
#		emit_signal("go_through_door")
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
		
func _position_player_to_door() -> void:
	if player != null:
		player.global_position = global_position

func _on_EndDoor_body_entered(body):
	emit_signal("open_door")
	player = body
	if isOpen:
		_position_player_to_door()
		get_node(OtherDoor)._position_player_to_door()
		emit_signal("go_through_door")
	
func _on_EndDoor_body_exited(body):
	emit_signal("close_door")
	
func set_state(state: int) -> void:
	if has_node("Sprite"):
		var sprite: Sprite = get_node("Sprite")
		sprite.frame = state % sprite.vframes

func _on_area_entered(area: Area2D) -> void:
	return

func _on_area_exited(area: Area2D) -> void:
	return

