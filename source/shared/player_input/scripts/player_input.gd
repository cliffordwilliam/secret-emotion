@icon("res://source/shared/player_input/assets/gamepad-2.svg")
class_name PlayerInput
extends Node
# The only thing that calls the Input singleton, so its not spammed everywhere


func get_input_direction_x() -> int:
	return int(Input.get_axis(InputConstants.LEFT_INPUT, InputConstants.RIGHT_INPUT))
