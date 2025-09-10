class_name PlayerSaveComponent
extends SaveComponent
# This is an extension of owner. It stores owner belongings
# Determine when to start owner state machine

var player: Player


func _ready() -> void:
	player = owner as Player


func read_world_state() -> void:
	# This func is responsible for starting state machine
	# So must ensure parent refs are ready in state base class
	await player.ready

	# Define my unique ID for world state key registration
	id = player.name

	# Read world state
	var raw_data: Dictionary = get_world_state()

	# Empty? Start state machine now
	if raw_data.is_empty():
		start_owner_state_machine_request.emit()
		return

	# Got something? Validate it
	if not _validate_state_machine(raw_data):
		return
	if not _validate_flip_h(raw_data):
		return
	if not _validate_position(raw_data):
		return

	# Apply world state to my props
	var save_data: PlayerSaveData = _raw_to_resource_schema(raw_data)
	_apply_loaded_data(save_data)
	# Start state machine now
	start_owner_state_machine_request.emit()


func _validate_state_machine(raw_data: Dictionary) -> bool:
	if not raw_data.has(PlayerSaveData.KEY_CURRENT_STATE_NAME):
		push_warning("Missing state name in player save data for id: %s" % id)
		return false
	var state_name: String = raw_data[PlayerSaveData.KEY_CURRENT_STATE_NAME]
	for child: PlayerState in player.player_state_machine.get_children():
		if child.name == state_name:
			return true
	push_warning("Invalid state '%s' in player save data for id: %s" % [state_name, id])
	return false


func _validate_flip_h(raw_data: Dictionary) -> bool:
	if not raw_data.has(PlayerSaveData.KEY_FLIP_H):
		push_warning("Missing flip_h in player save data for id: %s" % id)
		return false
	var raw_flip_h: String = raw_data[PlayerSaveData.KEY_FLIP_H]
	if raw_flip_h != "true" and raw_flip_h != "false":
		push_warning("Invalid flip_h '%s' in player save data for id: %s" % [raw_flip_h, id])
		return false
	return true


func _validate_position(raw_data: Dictionary) -> bool:
	if (
		not raw_data.has(PlayerSaveData.KEY_POSITION_X)
		or not raw_data.has(PlayerSaveData.KEY_POSITION_Y)
	):
		push_warning("Missing position in player save data for id: %s" % id)
		return false
	var raw_x: String = raw_data[PlayerSaveData.KEY_POSITION_X]
	var raw_y: String = raw_data[PlayerSaveData.KEY_POSITION_Y]
	if not raw_x.is_valid_float() or not raw_y.is_valid_float():
		push_warning(
			(
				"Position values must be floats (got '%s', '%s') in player save data for id: %s"
				% [raw_x, raw_y, id]
			)
		)
		return false
	return true


func _apply_loaded_data(save_data: PlayerSaveData) -> void:
	# Restore state machine
	var target_state: PlayerState = null
	for child: PlayerState in player.player_state_machine.get_children():
		if child.name == save_data.current_state_name:
			target_state = child
			break
	player.player_state_machine.initial_state = target_state
	# Restore transform
	player.position = Vector2(save_data.position_x, save_data.position_y)
	# Restore flip h
	player.player_animated_sprite.flip_h = save_data.flip_h


func dump_state_to_world() -> void:
	var save_data: PlayerSaveData = PlayerSaveData.new()
	save_data.current_state_name = player.player_state_machine.current_state.name
	save_data.position_x = player.position.x
	save_data.position_y = player.position.y
	save_data.flip_h = player.player_animated_sprite.flip_h
	var save_data_dict: Dictionary = _resource_schema_to_raw_dict(save_data)
	update_world_state(save_data_dict)


func _raw_to_resource_schema(raw_data: Dictionary) -> PlayerSaveData:
	var save_data: PlayerSaveData = PlayerSaveData.new()
	save_data.current_state_name = StringName(raw_data[PlayerSaveData.KEY_CURRENT_STATE_NAME])
	save_data.flip_h = raw_data[PlayerSaveData.KEY_FLIP_H] == "true"
	save_data.position_x = raw_data[PlayerSaveData.KEY_POSITION_X].to_float()
	save_data.position_y = raw_data[PlayerSaveData.KEY_POSITION_Y].to_float()
	return save_data


func _resource_schema_to_raw_dict(save_data: PlayerSaveData) -> Dictionary:
	return {
		PlayerSaveData.KEY_CURRENT_STATE_NAME: str(save_data.current_state_name),
		PlayerSaveData.KEY_FLIP_H: str(save_data.flip_h),
		PlayerSaveData.KEY_POSITION_X: str(save_data.position_x),
		PlayerSaveData.KEY_POSITION_Y: str(save_data.position_y),
	}
