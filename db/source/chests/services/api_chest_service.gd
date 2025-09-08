class_name ApiChestService
extends RefCounted


static func get_in_current_context(chest_name: String) -> ApiChestResponseDto:
	# 1. Get current active slot
	var active_slot: ApiSlotResponseDto = ApiSlotRepository.get_active_slot()
	if not active_slot:
		return _error("No active slot found")

	# 2. Get current active room in that slot
	var current_room: ApiRoomResponseDto = ApiRoomRepository.get_current_room(active_slot.slot_id)
	if current_room.error:
		return _error("No current room found in slot '%s'" % active_slot.slot_name)

	# 3. Get chest by name in that room
	return ApiChestRepository.get_by_room_and_name(current_room.room_id, chest_name)


static func update_in_current_context(
	chest_name: String, chest_state: String
) -> ApiChestResponseDto:
	# 1. Get current active slot
	var active_slot: ApiSlotResponseDto = ApiSlotRepository.get_active_slot()
	if not active_slot:
		return _error("No active slot found")

	# 2. Get current active room in that slot
	var current_room: ApiRoomResponseDto = ApiRoomRepository.get_current_room(active_slot.slot_id)
	if current_room.error:
		return _error("No current room found in slot '%s'" % active_slot.slot_name)

	var chest_edit_dto: ApiChestEditDto = (
		ApiChestEditDto
		. new(
			{
				"slot_name": active_slot.slot_name,
				"room_name": current_room.room_name,
				"chest_name": chest_name,
				"chest_state": chest_state,
			}
		)
	)

	return update(chest_edit_dto)


static func create_in_current_context(
	chest_name: String, chest_state: String
) -> ApiChestResponseDto:
	# 1. Get current active slot
	var active_slot: ApiSlotResponseDto = ApiSlotRepository.get_active_slot()
	if not active_slot:
		return _error("No active slot found")

	# 2. Get current active room in that slot
	var current_room: ApiRoomResponseDto = ApiRoomRepository.get_current_room(active_slot.slot_id)
	if current_room.error:
		return _error("No current room found in slot '%s'" % active_slot.slot_name)

	var existing: ApiChestResponseDto = ApiChestRepository.get_by_room_and_name(
		current_room.room_id, chest_name
	)
	if not existing.error:
		return _error(
			(
				"Chest '%s' already exists in room '%s' (slot '%s')"
				% [chest_name, current_room.room_name, active_slot.slot_name]
			)
		)

	var chest_create_dto: ApiChestCreateDto = (
		ApiChestCreateDto
		. new(
			{
				"slot_name": active_slot.slot_name,
				"room_name": current_room.room_name,
				"chest_name": chest_name,
				"chest_state": chest_state,
			}
		)
	)

	return ApiChestRepository.create(current_room.room_id, chest_create_dto)


static func create(chest_create_dto: ApiChestCreateDto) -> ApiChestResponseDto:
	var slot: ApiSlotResponseDto = ApiSlotRepository.get_by_name(chest_create_dto.slot_name)
	if slot.error:
		return _error("Slot '%s' not found" % chest_create_dto.slot_name)

	var room: ApiRoomResponseDto = ApiRoomRepository.get_by_slot_and_name(
		slot.slot_id, chest_create_dto.room_name
	)
	if room.error:
		return _error(
			(
				"Room '%s' not found in slot '%s'"
				% [chest_create_dto.room_name, chest_create_dto.slot_name]
			)
		)

	var existing: ApiChestResponseDto = ApiChestRepository.get_by_room_and_name(
		room.room_id, chest_create_dto.chest_name
	)
	if not existing.error:
		return _error(
			(
				"Chest '%s' already exists in room '%s' (slot '%s')"
				% [
					chest_create_dto.chest_name,
					chest_create_dto.room_name,
					chest_create_dto.slot_name
				]
			)
		)

	return ApiChestRepository.create(room.room_id, chest_create_dto)


static func update(chest_edit_dto: ApiChestEditDto) -> ApiChestResponseDto:
	var slot: ApiSlotResponseDto = ApiSlotRepository.get_by_name(chest_edit_dto.slot_name)
	if slot.error:
		return _error("Slot '%s' not found" % chest_edit_dto.slot_name)

	var room: ApiRoomResponseDto = ApiRoomRepository.get_by_slot_and_name(
		slot.slot_id, chest_edit_dto.room_name
	)
	if room.error:
		return _error(
			(
				"Room '%s' not found in slot '%s'"
				% [chest_edit_dto.room_name, chest_edit_dto.slot_name]
			)
		)

	var existing: ApiChestResponseDto = ApiChestRepository.get_by_room_and_name(
		room.room_id, chest_edit_dto.chest_name
	)
	if existing.error:
		return _error(
			(
				"Chest '%s' not found in room '%s' (slot '%s')"
				% [chest_edit_dto.chest_name, chest_edit_dto.room_name, chest_edit_dto.slot_name]
			)
		)

	return ApiChestRepository.update(room.room_id, chest_edit_dto)


static func _error(message: String) -> ApiChestResponseDto:
	return ApiChestResponseDto.new({}, message)
