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

	# Fetch data from db
	# Get the slot we want
	var found_active_slot: ApiSlotResponseDto = ApiSlotService.get_active_slot()
	if found_active_slot.error:
		return
	# Get a room from this slot
	var found_active_room: ApiRoomResponseDto = ApiRoomRepository.get_active_room_by_slot_id(
		found_active_slot.slot_id
	)
	if found_active_room.error:
		return
	# Get chest in that room
	var chest_data: ApiChestResponseDto = (
		ApiChestService
		. get_by_slot_name_room_name_and_chest_name(
			ApiStringParamDto.new(found_active_slot.slot_name),
			ApiStringParamDto.new(found_active_room.room_name),
			ApiStringParamDto.new(chest.name),
		)
	)

	if not chest_data.error:
		# Rehydrate self using that chest
		_rehydrate_self_with_loaded_data(chest_data)
		# Start state machine now
		properties_initialized_by_save_file.emit()
		return
	# Not found? Make new one
	var created_chest: ApiChestResponseDto = (
		ApiChestService
		. create(
			ApiStringParamDto.new(found_active_slot.slot_name),
			ApiStringParamDto.new(found_active_room.room_name),
			(
				ApiChestCreateDto
				. new(
					{
						"chest_name": chest.name,
						"chest_state": chest.chest_state_machine.initial_state.name,
					}
				)
			)
		)
	)
	if created_chest.error:
		print(created_chest.error_message)
		return
	# Start state machine
	properties_initialized_by_save_file.emit()
	return


func _rehydrate_self_with_loaded_data(chest_data: ApiChestResponseDto) -> void:
	# Restore state machine
	for child: ChestState in chest.chest_state_machine.get_children():
		if child.name == chest_data.chest_state:
			chest.chest_state_machine.set_initial_state(child)
			break


func dump_state_to_world(slot_name: String = "") -> void:
	# Get the slot we want
	var found_slot: ApiSlotResponseDto
	if slot_name.strip_edges() != "":
		found_slot = ApiSlotService.get_by_name(slot_name)
	else:
		found_slot = ApiSlotService.get_active_slot()
	if found_slot.error:
		return
	# Get a room from this slot
	var found_active_room: ApiRoomResponseDto = ApiRoomRepository.get_active_room_by_slot_id(
		found_slot.slot_id
	)
	if found_active_room.error:
		return
	# Update chest in that room
	var result: ApiChestResponseDto = (
		ApiChestService
		. update(
			ApiStringParamDto.new(found_slot.slot_name),
			ApiStringParamDto.new(found_active_room.room_name),
			(
				ApiChestEditDto
				. new(
					{
						"chest_name": chest.name,
						"chest_state": chest.chest_state_machine.current_state.name,
					}
				)
			)
		)
	)
	if result.error:
		return
