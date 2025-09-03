class_name ChestSaveComponent
extends SaveComponent
# This is an extension of owner. It stores owner belongings
# Determine when to start owner state machine

var chest: Chest


func _ready() -> void:
	chest = owner as Chest


func read_world_state() -> void:
	# This func is responsible for starting state machine
	# So must ensure parent refs are ready in state base class
	await chest.ready

	# Define my unique ID for world state key registration
	id = chest.name

	# Read world state
	var raw_data: Dictionary = get_world_state()

	# Empty? Start state machine now
	if raw_data.is_empty():
		start_owner_state_machine_request.emit()
		return

	# Got something? Validate it
	if not _validate_state_machine(raw_data):
		return

	# Apply world state to my props
	var save_data: ChestSaveData = _raw_to_resource_schema(raw_data)
	_apply_loaded_data(save_data)
	# Start state machine now
	start_owner_state_machine_request.emit()


func _validate_state_machine(raw_data: Dictionary) -> bool:
	if not raw_data.has(ChestSaveData.KEY_CURRENT_STATE_NAME):
		push_warning("Missing state name in chest save data for id: %s" % id)
		return false

	var state_name: String = raw_data[ChestSaveData.KEY_CURRENT_STATE_NAME]
	for child in chest.chest_state_machine.get_children():
		if child.name == state_name:
			return true

	push_warning("Invalid state '%s' in chest save data for id: %s" % [state_name, id])
	return false


func _apply_loaded_data(save_data: ChestSaveData) -> void:
	# Restore state machine
	var target_state: ChestState = null
	for child in chest.chest_state_machine.get_children():
		if child.name == save_data.current_state_name:
			target_state = child
			break
	chest.chest_state_machine.initial_state = target_state


func dump_state_to_world() -> void:
	var save_data: ChestSaveData = ChestSaveData.new()
	save_data.current_state_name = chest.chest_state_machine.current_state.name
	var save_data_dict: Dictionary = _resource_schema_to_raw_dict(save_data)
	update_world_state(save_data_dict)


func _raw_to_resource_schema(raw_data: Dictionary) -> ChestSaveData:
	var save_data = ChestSaveData.new()
	save_data.current_state_name = StringName(raw_data[ChestSaveData.KEY_CURRENT_STATE_NAME])
	return save_data


func _resource_schema_to_raw_dict(save_data: ChestSaveData) -> Dictionary:
	return {
		ChestSaveData.KEY_CURRENT_STATE_NAME: str(save_data.current_state_name),
	}
