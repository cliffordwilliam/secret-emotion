class_name PineAnimatedSprite
extends AnimatedSprite2D

@export var animation_name_data: PineAnimationNameData


func _ready() -> void:
	_validate_gui()
	randomize()
	play(animation_name_data.SWAY)
	var frame_count = sprite_frames.get_frame_count(animation)
	frame = randi() % frame_count


func _validate_gui():
	for anim in sprite_frames.get_animation_names():
		if anim not in animation_name_data.ALL:
			push_error("❌ GUI 'PineAnimatedSprite' animation name missing: '%s'" % anim)
			get_tree().quit(1)

	print("✅ GUI 'PineAnimatedSprite' animation name valid.")
