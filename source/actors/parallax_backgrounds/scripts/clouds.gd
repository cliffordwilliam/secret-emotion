class_name Clouds
extends Parallax2D
# Scroll rivers each frame


func _physics_process(delta: float) -> void:
	scroll_offset.x += CloudsMovementData.FLOAT_SPEED * delta
	scroll_offset.x = fposmod(scroll_offset.x, repeat_size.x)
