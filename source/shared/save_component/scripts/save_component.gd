@icon("res://source/shared/save_component/assets/save.svg")
class_name SaveComponent
extends Node
# Declare actor ID (unique db row field to define with node name)
# Actor ID unique naming format = RoomNameActor0 (VillageChest1)

@warning_ignore("unused_signal")
signal properties_initialized_by_save_file

# Define my unique ID for world state key registration
@onready var id: StringName = owner.name


func _ready() -> void:
	owner.add_to_group(GroupNameConstants.SAVABLES)
	_kid_ready()


func _kid_ready() -> void:
	pass


# TODO: Delete this, anyone just use the domain services
# TODO: This should now target sqlite layer 2 mem
func set_one_object_in_world_state_by_id(
	given_id: StringName, state_dictionary: Dictionary
) -> void:
	WorldState.set_one_object_in_world_state_by_id(given_id, state_dictionary)


# TODO: Delete this, anyone just use the domain services
# TODO: This should now target sqlite layer 2 mem
func get_one_object_in_world_state_by_id(given_id: StringName) -> Dictionary:
	return WorldState.get_one_object_in_world_state_by_id(given_id)
