class_name ChestSaveComponent
extends SaveComponent
# Stores owner belongings (so lsp knows owner 'Chest' type)
# On ready it sync with world state

var chest: Chest


func _ready() -> void:
	chest = owner as Chest
	await chest.ready
	var raw_data: Dictionary = get_world_state()
	if raw_data.is_empty():
		_dump_state()
		return
	if not _validate_raw(raw_data):
		return
	var save_data: ChestSaveData = _raw_to_resource(raw_data)
	_world_sync(save_data)


func _validate_raw(raw_data: Dictionary) -> bool:
	if not raw_data.has(ChestSaveData.KEY_CURRENT_STATE_PATH):
		push_warning("Missing state path in chest save data for id: %s" % id)
		return false

	if typeof(raw_data[ChestSaveData.KEY_CURRENT_STATE_PATH]) != TYPE_NODE_PATH:
		push_warning("State path must be NodePath in chest save data for id: %s" % id)
		return false

	var state_path: NodePath = raw_data[ChestSaveData.KEY_CURRENT_STATE_PATH]
	var target_state: Node = chest.chest_state_machine.get_node_or_null(state_path)

	if target_state not in chest.chest_state_machine.get_children():
		push_warning("Resolved state is not a child of the chest state machine: %s" % state_path)
		return false

	return true


func _raw_to_resource(raw_data: Dictionary) -> ChestSaveData:
	var save_data = ChestSaveData.new()
	save_data.current_state_path = raw_data[ChestSaveData.KEY_CURRENT_STATE_PATH]
	return save_data


func _world_sync(save_data: ChestSaveData) -> void:
	var state_node_path: NodePath = save_data.current_state_path
	var target_state: ChestState = chest.chest_state_machine.get_node_or_null(state_node_path)
	chest.chest_state_machine.change_state(target_state)


func _dump_state() -> void:
	var save_data: ChestSaveData = ChestSaveData.new()
	save_data.current_state_path = chest.chest_state_machine.current_state.get_path_to(
		chest.chest_state_machine
	)
	update_world_state(save_data)
