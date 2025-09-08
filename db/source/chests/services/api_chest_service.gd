class_name ApiChestService
extends RefCounted


static func get_in_current_context(chest_name: ApiStringParamDto) -> ApiChestResponseDto:
	# OK
	var active_slot: ApiSlotResponseDto = ApiSlotRepository.get_active_slot()
	if not active_slot:
		return _error("No active slot found")

	var current_room: ApiRoomResponseDto = ApiRoomRepository.get_current_room(active_slot.slot_id)
	if current_room.error:
		return _error("No current room found in slot '%s'" % active_slot.slot_name)

	return ApiChestRepository.get_by_room_and_name(current_room.room_id, chest_name.string_param)


static func update_in_current_context(
	# OK
	chest_context_edit_dto: ApiChestContextEditDto
) -> ApiChestResponseDto:
	var active_slot: ApiSlotResponseDto = ApiSlotRepository.get_active_slot()
	if not active_slot:
		return _error("No active slot found")

	var current_room: ApiRoomResponseDto = ApiRoomRepository.get_current_room(active_slot.slot_id)
	if current_room.error:
		return _error("No current room found in slot '%s'" % active_slot.slot_name)

	var chest_edit_dto: ApiChestEditDto = (
		ApiChestEditDto
		. new(
			{
				"slot_name": active_slot.slot_name,
				"room_name": current_room.room_name,
				"chest_name": chest_context_edit_dto.chest_name,
				"chest_state": chest_context_edit_dto.chest_state,
			}
		)
	)
	return ApiChestRepository.update(current_room.room_id, chest_edit_dto)


static func create_in_current_context(
	chest_context_create_dto: ApiChestContextCreateDto
) -> ApiChestResponseDto:
	# OK
	var active_slot: ApiSlotResponseDto = ApiSlotRepository.get_active_slot()
	if not active_slot:
		return _error("No active slot found")

	var current_room: ApiRoomResponseDto = ApiRoomRepository.get_current_room(active_slot.slot_id)
	if current_room.error:
		return _error("No current room found in slot '%s'" % active_slot.slot_name)

	var existing: ApiChestResponseDto = ApiChestRepository.get_by_room_and_name(
		current_room.room_id, chest_context_create_dto.chest_name
	)
	if not existing.error:
		return _error(
			(
				"Chest '%s' already exists in room '%s' (slot '%s')"
				% [
					chest_context_create_dto.chest_name,
					current_room.room_name,
					active_slot.slot_name
				]
			)
		)

	return (
		ApiChestRepository
		. create(
			current_room.room_id,
			(
				ApiChestCreateDto
				. new(
					{
						"slot_name": active_slot.slot_name,
						"room_name": current_room.room_name,
						"chest_name": chest_context_create_dto.chest_name,
						"chest_state": chest_context_create_dto.chest_state,
					}
				)
			),
		)
	)


static func _error(message: String) -> ApiChestResponseDto:
	return ApiChestResponseDto.new({}, message)
