class_name Player
extends CharacterBody2D
# Listens to input and update its position with collision resolution

@warning_ignore("unused_signal")
signal face_direction(is_facing_left: bool)
@warning_ignore("unused_signal")
signal play_animation(animation_name: StringName)

@export var movement_data: PlayerMovementData
@export var animation_name_data: PlayerAnimationNameData

var is_facing_left: bool = false

@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var player_input: PlayerInput = $PlayerInput


func set_facing_direction(is_left: bool) -> void:
	if is_left == is_facing_left:
		return
	is_facing_left = is_left
	face_direction.emit(is_facing_left)
	play_animation.emit(animation_name_data.TURN_TO_RUN)


func _physics_process(delta):
	player_state_machine.physics_process(delta)
