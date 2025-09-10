class_name ChestSaveComponent
extends SaveComponent

@onready var chest: Chest = owner as Chest


func read_world_state() -> void:
	await chest.ready

	var raw_data: Dictionary = get_world_state()

	if raw_data.is_empty():
		data_loaded.emit()
		return

	_rehydrate(_to_dto(raw_data))
	data_loaded.emit()


func _rehydrate(save_data: ChestSaveData) -> void:
	for child: ChestState in chest.chest_state_machine.get_children():
		if child.name == save_data.current_state_name:
			chest.chest_state_machine.initial_state = child
			break


func dump_state_to_world() -> void:
	var save_data: ChestSaveData = ChestSaveData.new()
	save_data.current_state_name = chest.chest_state_machine.current_state.name
	update_world_state(_to_raw(save_data))


func _to_dto(raw_data: Dictionary) -> ChestSaveData:
	var save_data: ChestSaveData = ChestSaveData.new()
	save_data.current_state_name = StringName(raw_data[ChestSaveData.KEY_CURRENT_STATE_NAME])
	return save_data


func _to_raw(save_data: ChestSaveData) -> Dictionary:
	return {
		ChestSaveData.KEY_CURRENT_STATE_NAME: str(save_data.current_state_name),
	}
