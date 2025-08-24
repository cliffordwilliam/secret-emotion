# This is an autoload class (WorldState)
extends Node
# Manages world state + ability to IO it

enum SaveSlot { SLOT_0, SLOT_1, SLOT_2 }

const SAVE_PATH_PREFIX := "user://save_slot_"
const SAVE_FILE_EXTENSION := ".json"

var world_state: Dictionary = {}


# TODO: No need? Just dump local world state to disk right?
func set_world_state(actor_id: String, state: Dictionary) -> void:
	world_state[actor_id] = state


# TODO: No need? Just dump local world state to disk right?
func get_world_state(actor_id: String) -> Dictionary:
	if world_state.has(actor_id):
		return world_state[actor_id]
	return {}


func save_to_slot(slot_name: SaveSlot) -> void:
	var file = FileAccess.open(
		SAVE_PATH_PREFIX + str(slot_name) + SAVE_FILE_EXTENSION, FileAccess.WRITE
	)
	file.store_line(JSON.stringify(world_state))
	file.close()


func load_from_slot(slot_name: SaveSlot) -> void:
	var file = FileAccess.open(
		SAVE_PATH_PREFIX + str(slot_name) + SAVE_FILE_EXTENSION, FileAccess.READ
	)
	var data = JSON.parse_string(file.get_as_text())
	file.close()
	world_state = data
