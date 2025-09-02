class_name ChestSaveComponent
extends SaveComponent
# This is an extension of owner. It stores owner belongings
# Determine when to start owner state machine

signal start_owner_state_machine_request

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
	if not _validate_raw(raw_data):
		return

	# Apply world state to my props
	var save_data: ChestSaveData = _raw_to_resource_schema(raw_data)
	_apply_loaded_data(save_data)


func _validate_raw(raw_data: Dictionary) -> bool:
	if not raw_data.has(ChestSaveData.KEY_CURRENT_STATE_NAME):
		push_warning("Missing state name in chest save data for id: %s" % id)
		return false

	var found := false
	for child in chest.chest_state_machine.get_children():
		if child.name == raw_data[ChestSaveData.KEY_CURRENT_STATE_NAME]:
			found = true
			break
	if not found:
		push_warning(
			(
				"Invalid state '%s' in chest save data for id: %s"
				% [raw_data[ChestSaveData.KEY_CURRENT_STATE_NAME], id]
			)
		)

	var state_name: StringName = raw_data[ChestSaveData.KEY_CURRENT_STATE_NAME]
	for child in chest.chest_state_machine.get_children():
		if child.name == state_name:
			return true

	push_warning("No state with matching name found: %s" % state_name)
	return false


func _apply_loaded_data(save_data: ChestSaveData) -> void:
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
	start_owner_state_machine_request.emit()


func dump_state_to_world() -> void:
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
