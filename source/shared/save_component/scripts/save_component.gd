@icon("res://source/shared/save_component/assets/save.svg")
class_name SaveComponent
extends Node
# Declare actor ID (unique name) and has methods to talk to WorldState autoload

var id: StringName = ""


func update_world_state(state_dictionary: Dictionary):
	WorldState.set_world_state(id, state_dictionary)


func get_world_state() -> Dictionary:
	return WorldState.get_world_state(id)
