# Autoload WorldState
extends Node

enum SaveSlot { SLOT_0, SLOT_1, SLOT_2 }

const SAVE_PATH_PREFIX: String = "user://secret_emotion_save_slot_"
const SAVE_FILE_EXTENSION: String = ".json"

var world_state: Dictionary = {}


func set_world_state(actor_id: String, state: Dictionary) -> void:
	world_state[actor_id] = state


func get_world_state(actor_id: String) -> Dictionary:
	if world_state.has(actor_id):
		return world_state[actor_id]
	return {}


func dump_to_disk(slot_name: SaveSlot) -> void:
	var file: FileAccess = FileAccess.open(
		SAVE_PATH_PREFIX + str(slot_name) + SAVE_FILE_EXTENSION, FileAccess.WRITE
	)
	file.store_line(JSON.stringify(world_state))
	file.close()


func hydrate_world(slot_name: SaveSlot) -> void:
	var path: String = SAVE_PATH_PREFIX + str(slot_name) + SAVE_FILE_EXTENSION
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	if not file:
		return
	var text: String = file.get_as_text()
	file.close()
	world_state = JSON.parse_string(text) as Dictionary
