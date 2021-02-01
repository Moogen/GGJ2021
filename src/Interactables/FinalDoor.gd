extends "res://Interactables/EndDoor.gd"


export(NodePath) var player1
export(NodePath) var player2

signal win_game
var player_count = 0

func _ready() -> void:
	_check_for_sprite()
	if has_node("Sprite"):
		var sprite: Sprite = get_node("Sprite")
		if sprite.frame != 2:
			connect("open_door", self, "_open")
			connect("close_door", self, "_close")
	
	connect("win_game", get_node(player1), "win_game")
	connect("win_game", get_node(player2), "hide")

func disable_player() -> void:
	if player != null:
		player.hide()

func _on_EndDoor_body_entered(body):
	emit_signal("open_door")
	player = body
	player_count += 1
	if isOpen:
		_position_player_to_door()
	
	if player_count == 2:
		emit_signal("win_game")
		yield(get_tree().create_timer(2), "timeout")
		get_tree().current_scene.load_next_level()

func _on_EndDoor_body_exited(body):
	player_count -= 1
	if player_count == 0:
		emit_signal("close_door")

