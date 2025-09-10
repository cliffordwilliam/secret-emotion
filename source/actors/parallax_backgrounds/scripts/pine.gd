class_name Pine
extends AnimatedSprite2D


func _ready() -> void:
	randomize()
	var frame_count: int = sprite_frames.get_frame_count(animation)
	frame = randi() % frame_count
