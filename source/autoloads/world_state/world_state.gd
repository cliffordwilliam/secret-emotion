# This is an autoload class (WorldState)
extends Node
# Manages world state + ability to IO it

enum SaveSlot { SLOT_0, SLOT_1, SLOT_2 }

const SAVE_PATH_PREFIX: String = "user://save_slot_"
const SAVE_FILE_EXTENSION: String = ".json"

var world_state: Dictionary = {}


func set_world_state(actor_id: String, state: Dictionary) -> void:
	world_state[actor_id] = state


func get_world_state(actor_id: String) -> Dictionary:
	if world_state.has(actor_id):
		return world_state[actor_id]
	return {}


func save_to_slot(slot_name: SaveSlot) -> void:
	var file: FileAccess = FileAccess.open(
		SAVE_PATH_PREFIX + str(slot_name) + SAVE_FILE_EXTENSION, FileAccess.WRITE
	)
	file.store_line(JSON.stringify(world_state))
	file.close()


func load_from_slot(slot_name: SaveSlot) -> Dictionary:
	var path: String = SAVE_PATH_PREFIX + str(slot_name) + SAVE_FILE_EXTENSION

	if not FileAccess.file_exists(path):
		print("No save file at slot:", slot_name)
		return {}

	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("Failed to open save file at slot: %s" % slot_name)
		return {}
	var text: String = file.get_as_text()
	file.close()

	var data: Variant = JSON.parse_string(text)
	if typeof(data) != TYPE_DICTIONARY:
		push_error("Corrupted save file at slot: %s" % slot_name)
		return {}

	world_state = data
	return data
