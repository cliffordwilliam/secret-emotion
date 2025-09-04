@icon("res://source/shared/save_component/assets/save.svg")
class_name SaveComponent
extends Node
# Declare actor ID (unique name for kid to define with node name)
# Actor ID should be its name using this format (RoomNameItem00)
# And has GET and PATCH for WorldState autoload

@warning_ignore("unused_signal")
signal properties_initialized_by_save_file

var id: StringName = ""


func _ready() -> void:
	owner.add_to_group(GroupNameConstants.SAVABLES)


func set_one_object_in_world_state_by_id(
	given_id: StringName, state_dictionary: Dictionary
) -> void:
	WorldState.set_one_object_in_world_state_by_id(given_id, state_dictionary)


func get_one_object_in_world_state_by_id(given_id: StringName) -> Dictionary:
	return WorldState.get_one_object_in_world_state_by_id(given_id)
