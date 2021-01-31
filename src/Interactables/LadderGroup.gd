extends Area2D

export(Level.LevelColor) var color setget set_color

var ladders: Array
onready var collision: CollisionShape2D = $CollisionShape2D

var is_interactable = true

func _on_area_entered(area: Area2D) -> void:
	print("hi")
	if is_interactable:
		for ladder in ladders:
			ladder.toggle_outline(true)

func _on_area_exited(area: Area2D) -> void:
	for ladder in ladders:
		ladder.toggle_outline(false)

func _ready():
	for child in get_children():
		if child is Ladder:
			ladders.append(child)
			
	# Set the ladder colors on init
	_update_ladder_sprites(color)
	
	# ladders.size() should equal the number of nested Ladders
	# Dynamically create the Collider based on how many ladders there are
	collision.shape.extents = Vector2(9, 14.5 * ladders.size())

func _init_ladder_colors(col: int) -> void:
	for ladder in ladders:
		ladder.init_color(col)
		
func _update_ladder_colors(col: int) -> void:
	for ladder in ladders:
		ladder.update_color(col)

func _update_ladder_sprites(col: int) -> void:
	for ladder in ladders:
		ladder.update_sprites(col)	
		
func update_color(col: int) -> void:
	if color == Level.LevelColor.BLACK:
		return
	
	if color == col:
		is_interactable = false
	else:
		is_interactable = true
		
	_update_ladder_colors(col)
	
# This function is only called in the editor
func set_color(col: int) -> void:
	print(col)
	color = col
