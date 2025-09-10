class_name Clouds
extends Parallax2D
const FLOAT_SPEED: float = 1.0


func _physics_process(delta: float) -> void:
	scroll_offset.x += FLOAT_SPEED * delta
	scroll_offset.x = fposmod(scroll_offset.x, repeat_size.x)
