class_name SaveMenuLoadModeStrategy
extends SaveMenuBaseModeStrategy
# TODO: Delete this, we want 2 seperated page, save and load
# TODO: But is that redundant? Yeah but at least its flexible and UI is messy in nature anyways


func can_handle(action: int) -> bool:
	return owner.action == owner.ActionType.LOAD


func on_ready_logic() -> void:
	owner.label.text = SaveMenuConfigData.LOAD_TITLE_TEXT


func on_button_pressed_logic(slot: WorldState.SaveSlot) -> void:
	WorldState.load_slot_from_disk(slot)

	var raw_data: Dictionary = WorldState.get_one_object_in_world_state_by_id(
		LocalWorldStateKeyConstants.CURRENT_ROOM_KEY
	)

	if raw_data.is_empty():
		owner.get_tree().change_scene_to_file(
			SaveMenuConfigData.FIRST_STARTING_ROOM_SCENE_FILE_PATH
		)
		return

	if not raw_data.has(LocalWorldStateKeyConstants.ROOM_SCENE_PATH_KEY):
		owner.push_warning("Missing room scene path in save data")
		return

	owner.get_tree().change_scene_to_file(raw_data[LocalWorldStateKeyConstants.ROOM_SCENE_PATH_KEY])
