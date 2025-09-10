class_name Pine
extends AnimatedSprite2D


func _ready() -> void:
	randomize()
	frame = randi() % sprite_frames.get_frame_count(animation)
