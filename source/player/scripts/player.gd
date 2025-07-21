class_name Player
extends CharacterBody2D
# This class listens to input, and use it to update position

@warning_ignore_start("unused_signal") signal face_direction(is_facing_left: bool)
signal play_animation(animation_name: StringName)

@export var movement_data: PlayerMovementData
@export var animation_name_data: PlayerAnimationNameData

@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine


func _physics_process(delta):
	player_state_machine.physics_process(delta)


# States common methods
func get_input_direction_x() -> int:
	return int(Input.get_axis(InputConstants.LEFT_INPUT, InputConstants.RIGHT_INPUT))
