class_name Pine
extends ValidatedAnimatedSprite
# Draw and animate sprite
# Validates GUI against my resource (animation name)


func _ready() -> void:
	_validate_gui(PineAnimationNameData.ALL)
	randomize()
	play(PineAnimationNameData.SWAY)
	frame = randi() % sprite_frames.get_frame_count(animation)
