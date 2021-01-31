extends Interactable


var collider: CollisionShape2D = null

func _ready():
	if has_node("StaticBody2D/CollisionShape2D"):
		collider = get_node("StaticBody2D/CollisionShape2D")
	else:
		assert(false, "Please add a collider to the obstacle")
	_check_for_sprite()

func update_color(background_color: int) -> void:
	if background_color == color:
		collider.set_deferred("disabled", true)
		if has_node("SpriteInactive"):
			get_node("SpriteInactive").visible = true
			sprite.visible = false
		sprite.material = null 
	else:
		collider.set_deferred("disabled", false)
		if has_node("SpriteInactive"):
			get_node("SpriteInactive").visible = false
			sprite.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
