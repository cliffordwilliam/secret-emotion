class_name Ray
extends Parallax2D
# Scroll ray each frame


func _physics_process(delta: float) -> void:
	scroll_offset.x -= RayMovementData.FLOAT_SPEED * delta
	scroll_offset.x = fposmod(scroll_offset.x, repeat_size.x)
