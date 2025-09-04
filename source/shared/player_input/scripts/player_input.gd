@icon("res://source/shared/player_input/assets/gamepad-2.svg")
class_name PlayerInput
extends Node
# The only thing that calls the builtin Input singleton
# So its not spammed everywhere

@export var input_enabled: bool = true


func set_enable_input(value: bool) -> void:
	input_enabled = value


func get_input_direction_x() -> int:
	if not input_enabled:
		return 0
	return int(Input.get_axis(InputConstants.LEFT_INPUT_NAME, InputConstants.RIGHT_INPUT_NAME))


func is_shift_held() -> bool:
	if not input_enabled:
		return false
	return Input.is_action_pressed(InputConstants.SHIFT_INPUT_NAME)


func is_down_held() -> bool:
	if not input_enabled:
		return false
	return Input.is_action_pressed(InputConstants.DOWN_INPUT_NAME)


func is_jump_tapped() -> bool:
	if not input_enabled:
		return false
	return Input.is_action_just_pressed(InputConstants.JUMP_INPUT_NAME)


func is_jump_held() -> bool:
	if not input_enabled:
		return false
	return Input.is_action_pressed(InputConstants.JUMP_INPUT_NAME)


func is_up_tapped() -> bool:
	if not input_enabled:
		return false
	return Input.is_action_just_pressed(InputConstants.UP_INPUT_NAME)
