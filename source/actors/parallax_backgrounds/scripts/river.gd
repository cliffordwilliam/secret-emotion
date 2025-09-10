class_name River
extends ValidatedAnimatedSprite
# Draw and animate sprite
# Validates GUI against my resource (animation name)

@export var animation_name_data: RiverAnimationNameData


func _ready() -> void:
	_validate_gui(animation_name_data)
	play(animation_name_data.FLOW)
