class_name Player
extends CharacterBody2D
# Listens to input and update its position with collision resolution

@warning_ignore_start("unused_signal")
# Formatter workaround
signal face_direction(is_facing_left: bool)
signal play_animation(animation_name: StringName)

@export var movement_data: PlayerMovementData
@export var animation_name_data: PlayerAnimationNameData

@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var player_input: PlayerInput = $PlayerInput


func _physics_process(delta):
	player_state_machine.physics_process(delta)
