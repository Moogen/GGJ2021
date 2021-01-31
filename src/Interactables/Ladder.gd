extends Interactable

func interact():
	# Must override
	pass

func update_color(background_color: int) -> void:
	if color == Level.LevelColor.Black:
		return
