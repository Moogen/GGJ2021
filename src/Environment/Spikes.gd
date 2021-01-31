extends Interactable

func update_color(background_color: int) -> void:
	if background_color == color:
		get_node("CollisionShape2D").set_deferred("disabled",true)
		if has_node("SpriteInactive"):
			get_node("SpriteInactive").visible = true
			sprite.visible = false
		sprite.material = null 
	else:
		get_node("CollisionShape2D").set_deferred("disabled",false)
		if has_node("SpriteInactive"):
			get_node("SpriteInactive").visible = false
			sprite.visible = true

func _on_Spikes_body_entered(body: Node2D):
	if body.has_method("kill"):
		body.kill()
	pass # Replace with function body.
	
# This function is only called in the editor
func set_color(col: int) -> void:
	color = col
	if has_node("Sprite"):
		var sprite: Sprite = get_node("Sprite")
		var spriteInactive: Sprite = get_node("SpriteInactive")
		get_node("Sprite").frame = color % (sprite.hframes*sprite.vframes)
		get_node("SpriteInactive").frame = color % (spriteInactive.hframes*spriteInactive.vframes)
