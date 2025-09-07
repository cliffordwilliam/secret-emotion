class_name ChestAnimatedSprite
extends ValidatedAnimatedSprite
# Draw and animate sprite
# Validates GUI against my resource (animation name)


func _ready() -> void:
	_validate_gui(ChestAnimationNameData.ALL)


func skip_to_last_frame(animation_name: StringName) -> void:
	play(animation_name)
	frame = sprite_frames.get_frame_count(animation_name)
