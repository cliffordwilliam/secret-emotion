class_name RiverAnimatedSprite
extends ValidatedAnimatedSprite
# Draw and animate sprite
# Validates GUI against my resource (animation name)


func _ready() -> void:
	_validate_gui(RiverAnimationNameData)
	play(RiverAnimationNameData.FLOW)
