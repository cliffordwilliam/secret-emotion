@icon("res://source/shared/save_component/assets/save.svg")
class_name SaveComponent
extends Node
# Declare actor ID (unique db row field for kid to define with node name)
# Actor ID format = RoomNameActor0 (VillageChest1)
# And has GET and PATCH for SQLite mem layer 2

@warning_ignore("unused_signal")
signal properties_initialized_by_save_file

# Delegate assignment for kids, should be unique actor name for unique row field
var id: StringName = ""


func _ready() -> void:
	owner.add_to_group(GroupNameConstants.SAVABLES)
	_kid_ready()


func _kid_ready() -> void:
	pass


# TODO: This should now target sqlite layer 2 mem
func set_one_object_in_world_state_by_id(
	given_id: StringName, state_dictionary: Dictionary
) -> void:
	WorldState.set_one_object_in_world_state_by_id(given_id, state_dictionary)


# TODO: This should now target sqlite layer 2 mem
func get_one_object_in_world_state_by_id(given_id: StringName) -> Dictionary:
	return WorldState.get_one_object_in_world_state_by_id(given_id)
