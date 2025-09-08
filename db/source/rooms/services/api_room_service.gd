class_name ApiRoomService
extends RefCounted


static func create(room_create_dto: ApiRoomCreateDto) -> ApiRoomResponseDto:
	var slot: ApiSlotResponseDto = ApiSlotRepository.get_by_name(room_create_dto.slot_name)
	if slot.error:
		return _error("Slot '%s' not found" % room_create_dto.slot_name)

	var existing: ApiRoomResponseDto = ApiRoomRepository.get_by_slot_and_name(
		slot.slot_id, room_create_dto.room_name
	)
	if not existing.error:
		return _error(
			(
				"Room name '%s' is already taken for slot '%s'"
				% [room_create_dto.room_name, room_create_dto.slot_name]
			)
		)

	return ApiRoomRepository.create(slot.slot_id, room_create_dto)


static func get_current_room(slot_name_dto: ApiStringParamDto) -> ApiRoomResponseDto:
	var slot: ApiSlotResponseDto = ApiSlotRepository.get_by_name(slot_name_dto.string_param)
	if slot.error:
		return _error("Slot '%s' not found" % slot_name_dto.string_param)

	return ApiRoomRepository.get_current_room(slot.slot_id)


static func update(room_id: int, update_data: Dictionary) -> ApiRoomResponseDto:
	return ApiRoomRepository.update(room_id, update_data)


static func _error(message: String) -> ApiRoomResponseDto:
	return ApiRoomResponseDto.new({}, message)
