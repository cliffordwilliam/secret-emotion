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

	# Fetch from DB via service
	var chest_data: ApiChestResponseDto = ApiChestService.get_in_current_context(chest.name)
	if chest_data.error:
		# No save exists yet → start fresh AND make my new save
		ApiChestService.create_in_current_context(
			chest.name, chest.chest_state_machine.initial_state.name
		)
		properties_initialized_by_save_file.emit()
		return

	# Rehydrate self using DB DTO
	_rehydrate_self_with_loaded_data(chest_data)
	# Start state machine now
	properties_initialized_by_save_file.emit()


func _rehydrate_self_with_loaded_data(chest_data: ApiChestResponseDto) -> void:
	# Restore state machine
	var target_state: ChestState = null
	for child: ChestState in chest.chest_state_machine.get_children():
		if child.name == chest_data.chest_state:
			target_state = child
			break
	if target_state:
		chest.chest_state_machine.set_initial_state(target_state)
	else:
		push_warning(
			(
				"Invalid state '%s' in chest save data for chest_id %d"
				% [chest_data.current_state, chest_data.chest_id]
			)
		)


func dump_state_to_world() -> void:
	var result: ApiChestResponseDto = ApiChestService.update_in_current_context(
		chest.name, chest.chest_state_machine.current_state.name
	)
	if result.error:
		push_error("Failed to persist chest '%s': %s" % [chest.name, result.error_message])
