@icon("res://source/chest/assets/archive.svg")
class_name Chest
extends Area2D

@warning_ignore("unused_signal")
signal play_animation(animation_name: StringName)
@warning_ignore("unused_signal")
signal start_state_machine
@warning_ignore("unused_signal")
signal read_world_state
@warning_ignore("unused_signal")
signal skip_to_last_frame(animation_name: StringName)
signal set_enable_input(value: bool)
signal set_interaction_marker_active
signal set_interaction_marker_inactive
signal dump_state_to_world

@export var animation_name_data: ChestAnimationNameData

@onready var chest_state_machine: ChestStateMachine = $ChestStateMachine
@onready var chest_input: PlayerInput = $PlayerInput


func _ready() -> void:
	read_world_state.emit()


func _physics_process(delta):
	chest_state_machine.physics_process(delta)


func _on_body_entered(_body: Node2D) -> void:
	set_enable_input.emit(true)
	set_interaction_marker_active.emit()


func _on_body_exited(_body: Node2D) -> void:
	set_enable_input.emit(false)
	set_interaction_marker_inactive.emit()


func _on_room_changed() -> void:
	dump_state_to_world.emit()
