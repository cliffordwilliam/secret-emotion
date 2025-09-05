class_name SavePointAnimatedSprite
extends ValidatedAnimatedSprite
# Draw and animate sprite
# Validates GUI against my resource (animation name)


func _ready() -> void:
	_validate_gui(SavePointAnimationNameData)
