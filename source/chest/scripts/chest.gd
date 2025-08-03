@icon("res://source/chest/assets/archive.svg")
class_name Chest
extends Area2D

@warning_ignore("unused_signal")
signal play_animation_request(animation_name: StringName)
@warning_ignore("unused_signal")
signal start_state_machine_request
@warning_ignore("unused_signal")
signal read_world_state_request
@warning_ignore("unused_signal")
signal skip_to_last_frame_request(animation_name: StringName)
signal set_enable_input_request(value: bool)
signal set_interaction_marker_active_request
signal set_interaction_marker_inactive_request
signal dump_state_to_world_request

@export var animation_name_data: ChestAnimationNameData

@onready var chest_state_machine: ChestStateMachine = $ChestStateMachine
@onready var chest_input: PlayerInput = $PlayerInput


func _ready() -> void:
	read_world_state_request.emit()


func _physics_process(delta):
	chest_state_machine.physics_process(delta)


func _on_body_entered(_body: Node2D) -> void:
	set_enable_input_request.emit(true)
	set_interaction_marker_active_request.emit()


func _on_body_exited(_body: Node2D) -> void:
	set_enable_input_request.emit(false)
	set_interaction_marker_inactive_request.emit()


func _on_room_changed() -> void:
	dump_state_to_world_request.emit()
