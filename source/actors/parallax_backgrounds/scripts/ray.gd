class_name Ray
extends Parallax2D
# Scroll ray each frame

@export var movement_data: RayMovementData


func _physics_process(delta: float) -> void:
	scroll_offset.x -= movement_data.FLOAT_SPEED * delta
	scroll_offset.x = fposmod(scroll_offset.x, repeat_size.x)
