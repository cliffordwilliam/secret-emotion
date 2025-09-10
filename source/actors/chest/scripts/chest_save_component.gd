class_name ChestSaveComponent
extends SaveComponent

@onready var chest: Chest = owner as Chest


func read_world_state() -> void:
	await chest.ready
	var raw_data: Dictionary = get_world_state()
	if raw_data.is_empty():
		finished_reading.emit()
		return
	_rehydrate(raw_data)
	finished_reading.emit()


func _rehydrate(raw_data: Dictionary) -> void:
	for child: ChestState in chest.chest_state_machine.get_children():
		if child.name == StringName(raw_data[ChestSaveDataKeys.KEY_CURRENT_STATE_NAME]):
			chest.chest_state_machine.initial_state = child
			break


func dump_state_to_world() -> void:
	update_world_state(
		{
			ChestSaveDataKeys.KEY_CURRENT_STATE_NAME:
			str(chest.chest_state_machine.current_state.name),
		}
	)
