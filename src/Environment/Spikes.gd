extends Interactable

func update_color(background_color: int) -> void:
	if background_color == color:
		is_interactable=false
		if has_node("SpriteInactive"):
			get_node("SpriteInactive").visible = true
			sprite.visible = false
		sprite.material = null 
	else:
		is_interactable=true
		if has_node("SpriteInactive"):
			get_node("SpriteInactive").visible = false
			sprite.visible = true

func _on_Spikes_body_entered(body: Node2D):
	if is_interactable:
		if body.has_method("kill"):
			body.kill()
	pass # Replace with function body.
