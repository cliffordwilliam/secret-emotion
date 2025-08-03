class_name ChestSaveComponent
extends SaveComponent
# Stores owner belongings (so LSP knows owner is a 'Chest' type)
# On ready it syncs with world state and defines its id with the node name

var chest: Chest


func _on_owner_read_world_state() -> void:
	chest = owner as Chest
	id = chest.name

	# Save to local
	var raw_data: Dictionary = get_world_state()
	if raw_data.is_empty():
		chest.start_state_machine.emit()
		_dump_state()
		return

	# Load from local
	if not _validate_raw(raw_data):
		return
	var save_data: ChestSaveData = _raw_to_resource_schema(raw_data)
	_world_sync(save_data)


func _validate_raw(raw_data: Dictionary) -> bool:
	if not raw_data.has(ChestSaveData.KEY_CURRENT_STATE_NAME):
		push_warning("Missing state name in chest save data for id: %s" % id)
		return false

	if typeof(raw_data[ChestSaveData.KEY_CURRENT_STATE_NAME]) != TYPE_STRING_NAME:
		push_warning("State name must be StringName in chest save data for id: %s" % id)
		return false

	var state_name: StringName = raw_data[ChestSaveData.KEY_CURRENT_STATE_NAME]
	for child in chest.chest_state_machine.get_children():
		if child.name == state_name:
			return true

	push_warning("No state with matching name found: %s" % state_name)
	return false


func _world_sync(save_data: ChestSaveData) -> void:
	# Chest state machine current state
	var target_state: ChestState = null
	for child in chest.chest_state_machine.get_children():
		if child.name == save_data.current_state_name:
			target_state = child
			break
	if target_state == null:
		push_warning("Could not find state with name: %s" % save_data.current_state_name)
		return
	chest.chest_state_machine.initial_state = target_state
	chest.start_state_machine.emit()


func _dump_state() -> void:
	# Chest state machine current state
	var save_data: ChestSaveData = ChestSaveData.new()
	save_data.current_state_name = chest.chest_state_machine.current_state.name
	var save_data_dict: Dictionary = _resource_schema_to_dict(save_data)
	update_world_state(save_data_dict)


func _raw_to_resource_schema(raw_data: Dictionary) -> ChestSaveData:
	var save_data = ChestSaveData.new()
	save_data.current_state_name = raw_data[ChestSaveData.KEY_CURRENT_STATE_NAME]
	return save_data


func _resource_schema_to_dict(save_data: ChestSaveData) -> Dictionary:
	return {
		ChestSaveData.KEY_CURRENT_STATE_NAME: save_data.current_state_name,
	}
