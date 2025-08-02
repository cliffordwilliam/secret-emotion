extends AnimatedSprite2D

@export var animation_name_data: PineAnimationNameData


func _ready() -> void:
	randomize()
	play(animation_name_data.SWAY)
	var frame_count = sprite_frames.get_frame_count(animation)
	frame = randi() % frame_count
