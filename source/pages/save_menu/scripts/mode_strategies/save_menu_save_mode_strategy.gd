class_name SaveMenuSaveModeStrategy
extends SaveMenuBaseModeStrategy
# TODO: Delete this, we want 2 seperated page, save and load
# TODO: But is that redundant? Yeah but at least its flexible and UI is messy in nature anyways


func can_handle(action: int) -> bool:
	return owner.action == owner.ActionType.SAVE


func on_ready_logic() -> void:
	owner.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	owner.label.text = SaveMenuConfigData.SAVE_TITLE_TEXT
	owner.hide()


func on_button_pressed_logic(slot: WorldState.SaveSlot) -> void:
	# To tell current room to dump its actors to local world state
	owner.player_pressed_save_button.emit()
	WorldState.save_slot_to_disk(slot)
	owner.hide()
	owner.get_tree().paused = false
