@icon("res://source/shared/save_component/assets/save.svg")
class_name SaveComponent
extends Node
# Declare actor ID (unique name for kid to define with node name)
# And has GET and PATCH for WorldState autoload

@warning_ignore("unused_signal")
signal start_owner_state_machine_request

var id: StringName = ""


func update_world_state(state_dictionary: Dictionary):
	WorldState.set_world_state(id, state_dictionary)


func get_world_state() -> Dictionary:
	return WorldState.get_world_state(id)
