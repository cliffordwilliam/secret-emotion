@icon("res://source/shared/save_component/assets/save.svg")
class_name SaveComponent
extends Node
# Defines world actor ID and holds methods to talk to WorldState autoload

@export var id: StringName = ""


func update_world_state(state_resource: Resource):
	WorldState.set_world_state(id, state_resource.to_dict())


func get_world_state() -> Dictionary:
	if WorldState.has_actor_state(id):
		return WorldState.get_world_state(id)
	return {}
