class_name ChestAnimatedSprite
extends AnimatedSprite2D


func skip_to_last_frame(animation_name: StringName) -> void:
	play(animation_name)
	frame = sprite_frames.get_frame_count(animation_name)
