class_name Rivers
extends Parallax2D

const FLOW_SPEED: float = 2.0


func _physics_process(delta: float) -> void:
	scroll_offset.x -= FLOW_SPEED * delta
	scroll_offset.x = fposmod(scroll_offset.x, repeat_size.x)
