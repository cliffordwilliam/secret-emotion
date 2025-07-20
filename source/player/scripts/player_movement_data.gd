class_name PlayerMovementData
extends LoadableResource
# Player movement props

var walk_speed: float


func _apply_data() -> void:
	# Pretend disk -> props
	walk_speed = 28.0
