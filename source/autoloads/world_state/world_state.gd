# This is an autoload class (WorldState)
extends Node
# Manages world state + ability to IO it

enum SaveSlot { SLOT_0, SLOT_1, SLOT_2 }

var world_state: Dictionary = {}


func set_world_state(actor_id: String, state: Dictionary) -> void:
	world_state[actor_id] = state


func get_world_state(actor_id: String) -> Dictionary:
	return world_state[actor_id]


func save_to_slot(slot_name: SaveSlot) -> void:
	var file = FileAccess.open("user://save_slot_" + str(slot_name) + ".json", FileAccess.WRITE)
	file.store_line(JSON.stringify(world_state))
	file.close()


func load_from_slot(slot_name: SaveSlot) -> void:
	var file = FileAccess.open("user://save_slot_" + str(slot_name) + ".json", FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	file.close()
	world_state = data
