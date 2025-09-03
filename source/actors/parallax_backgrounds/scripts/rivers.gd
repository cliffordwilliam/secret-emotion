class_name Rivers
extends Parallax2D
# Scroll rivers each frame

@export var movement_data: RiversMovementData


func _physics_process(delta: float) -> void:
	scroll_offset.x -= movement_data.FLOW_SPEED * delta
	scroll_offset.x = fposmod(scroll_offset.x, repeat_size.x)
