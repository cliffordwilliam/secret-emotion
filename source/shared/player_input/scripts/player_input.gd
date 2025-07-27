@icon("res://source/shared/player_input/assets/gamepad-2.svg")
class_name PlayerInput
extends Node
# The only thing that calls the Input singleton, so its not spammed everywhere

@export var input_enabled: bool = true


func set_input_enabled(value: bool) -> void:
	input_enabled = value


func get_input_direction_x() -> int:
	if not input_enabled:
		return 0
	return int(Input.get_axis(InputConstants.LEFT_INPUT, InputConstants.RIGHT_INPUT))


func is_shift_held() -> int:
	if not input_enabled:
		return false
	return Input.is_action_pressed(InputConstants.SHIFT_INPUT)


func is_down_held() -> int:
	if not input_enabled:
		return false
	return Input.is_action_pressed(InputConstants.DOWN_INPUT)


func is_jump_tapped() -> int:
	if not input_enabled:
		return false
	return Input.is_action_just_pressed(InputConstants.JUMP_INPUT)


func is_jump_held() -> int:
	if not input_enabled:
		return false
	return Input.is_action_pressed(InputConstants.JUMP_INPUT)


func is_up_tapped() -> int:
	if not input_enabled:
		return false
	return Input.is_action_just_pressed(InputConstants.UP_INPUT)
