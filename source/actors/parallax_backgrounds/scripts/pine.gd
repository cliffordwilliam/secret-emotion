class_name PineAnimatedSprite
extends ValidatedAnimatedSprite
# Draw and animate sprite
# Validates GUI against my resource (animation name)


func _ready() -> void:
	_validate_gui(PineAnimationNameData)
	randomize()
	play(PineAnimationNameData.SWAY)
	var frame_count: int = sprite_frames.get_frame_count(animation)
	frame = randi() % frame_count
