class_name ChestSaveComponent
extends SaveComponent
# This is an extension of owner. It stores owner belongings
# Determine when to start owner state machine

var chest: Chest


func _kid_ready() -> void:
	# Called after parent ready
	chest = owner as Chest


func read_world_state() -> void:
	# This func is responsible for starting state machine
	# So must ensure parent refs are ready in state base class
	await chest.ready

	# Read world state
	var raw_data: Dictionary = get_one_object_in_world_state_by_id(id)

	# Empty? Start state machine now
	if raw_data.is_empty():
		properties_initialized_by_save_file.emit()
		return

	# TODO: sqlite repo should return type save, delegate validation to db DTO and just use it here
	# Got something? Validate it
	if not _validate_state_machine(raw_data):
		return

	# Apply world state to my props
	var save_data: ChestSaveData = _raw_to_resource_schema(raw_data)
	_rehydrate_self_with_loaded_data(save_data)
	# Start state machine now
	properties_initialized_by_save_file.emit()


func _validate_state_machine(raw_data: Dictionary) -> bool:
	if not raw_data.has(ChestSaveData.KEY_CURRENT_STATE_NAME):
		push_warning("Missing state name in chest save data for id: %s" % id)
		return false

	var state_name: String = raw_data[ChestSaveData.KEY_CURRENT_STATE_NAME]
	for child: ChestState in chest.chest_state_machine.get_children():
		if child.name == state_name:
			return true

	push_warning("Invalid state '%s' in chest save data for id: %s" % [state_name, id])
	return false


# TODO: No need for chest save date schema anymore, use db dto instance that we get from response
func _rehydrate_self_with_loaded_data(save_data: ChestSaveData) -> void:
	# Restore state machine
	var target_state: ChestState = null
	for child: ChestState in chest.chest_state_machine.get_children():
		if child.name == save_data.current_state_name:
			target_state = child
			break
	chest.chest_state_machine.set_initial_state(target_state)


# TODO: Use db dto to create a new instance of it and make req to it to PATCH
func dump_state_to_world() -> void:
	var save_data: ChestSaveData = ChestSaveData.new()
	save_data.current_state_name = chest.chest_state_machine.current_state.name
	var save_data_dict: Dictionary = _resource_schema_to_raw_dict(save_data)
	set_one_object_in_world_state_by_id(id, save_data_dict)


# TODO: No need since db gives us instanced DTO validated
func _raw_to_resource_schema(raw_data: Dictionary) -> ChestSaveData:
	var save_data: ChestSaveData = ChestSaveData.new()
	save_data.current_state_name = StringName(raw_data[ChestSaveData.KEY_CURRENT_STATE_NAME])
	return save_data


# TODO: No need since db expects DTO input instance not raw dicts
func _resource_schema_to_raw_dict(save_data: ChestSaveData) -> Dictionary:
	return {
		ChestSaveData.KEY_CURRENT_STATE_NAME: str(save_data.current_state_name),
	}
