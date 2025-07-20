class_name PlayerStateData
extends StateData
# Player state machine props


func _apply_data() -> void:
	# Pretend disk -> props
	initial_state_path = "PlayerIdleState"
