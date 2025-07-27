extends Parallax2D

@export var movement_data: CloudMovementData


func _physics_process(delta: float) -> void:
	scroll_offset.x += movement_data.FLOAT_SPEED * delta
	scroll_offset.x = fposmod(scroll_offset.x, repeat_size.x)
