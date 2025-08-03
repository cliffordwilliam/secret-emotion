class_name Player
extends CharacterBody2D
# Listens to input and update its position with collision resolution

@warning_ignore("unused_signal")
signal face_direction_request(is_facing_left: bool)
@warning_ignore("unused_signal")
signal play_animation_request(animation_name: StringName)
@warning_ignore("unused_signal")
signal camera_follow_request(node: Node2D)
signal start_state_machine_request

@export var movement_data: PlayerMovementData
@export var animation_name_data: PlayerAnimationNameData

@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var player_input: PlayerInput = $PlayerInput


func _ready() -> void:
	await owner.ready
	camera_follow_request.emit(self)
	start_state_machine_request.emit()


func _physics_process(delta):
	player_state_machine.physics_process(delta)


func _reposition_to_door_request(given_global_position: Vector2) -> void:
	global_position = given_global_position
