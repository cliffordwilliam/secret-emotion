@icon("res://source/shared/save_component/assets/save.svg")
class_name SaveComponent
extends Node

@warning_ignore("unused_signal")
signal data_loaded

@onready var id: StringName = owner.name


func _ready() -> void:
	add_to_group(GroupNameConstants.SAVABLES)


func update_world_state(state_dictionary: Dictionary) -> void:
	WorldState.set_world_state(id, state_dictionary)


func get_world_state() -> Dictionary:
	return WorldState.get_world_state(id)
