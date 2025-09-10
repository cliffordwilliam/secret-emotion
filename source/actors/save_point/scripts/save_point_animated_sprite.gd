class_name SavePointAnimatedSprite
extends ValidatedAnimatedSprite
# Draw and animate sprite
# Validates GUI against my resource (animation name)

@export var animation_name_data: SavePointAnimationNameData


func _ready() -> void:
	_validate_gui(animation_name_data)
