class_name ApiRoomService
extends RefCounted


static func create(
	slot_name_dto: ApiStringParamDto, room_create_dto: ApiRoomCreateDto
) -> ApiRoomResponseDto:
	var slot: ApiSlotResponseDto = ApiSlotRepository.get_by_name(slot_name_dto.string_param)
	if slot.error:
		return ApiRoomResponseDto.err("Slot '%s' not found" % slot_name_dto.string_param)
	var existing_room: ApiRoomResponseDto = ApiRoomRepository.get_by_slot_id_and_name(
		slot.slot_id, room_create_dto.room_name
	)
	if not existing_room.error:
		return ApiRoomResponseDto.err(
			(
				"Slot '%s' already have room '%s'"
				% [slot_name_dto.string_param, room_create_dto.room_name]
			)
		)
	if room_create_dto.active_status:
		ApiRoomRepository.deactivate_all_by_slot_id(slot.slot_id)
	return ApiRoomRepository.create(slot.slot_id, room_create_dto)


static func get_active_room_by_slot_name(slot_name_dto: ApiStringParamDto) -> ApiRoomResponseDto:
	var slot: ApiSlotResponseDto = ApiSlotRepository.get_by_name(slot_name_dto.string_param)
	if slot.error:
		return ApiRoomResponseDto.err("Slot '%s' not found" % slot_name_dto.string_param)
	return ApiRoomRepository.get_active_room_by_slot_id(slot.slot_id)


static func activate_room_by_name_and_slot_name(
	room_name_dto: ApiStringParamDto, slot_name_dto: ApiStringParamDto
) -> ApiRoomResponseDto:
	var slot: ApiSlotResponseDto = ApiSlotRepository.get_by_name(slot_name_dto.string_param)
	if slot.error:
		return ApiRoomResponseDto.err("Slot '%s' not found" % slot.slot_name)
	var target_room: ApiRoomResponseDto = ApiRoomRepository.get_by_name_and_slot_id(
		room_name_dto.string_param, slot.slot_id
	)
	if target_room.error:
		return target_room
	if target_room.active_status:
		return target_room
	ApiRoomRepository.deactivate_all_by_slot_id(slot.slot_id)
	if ApiRoomRepository.activate_by_id(target_room.room_id):
		return ApiRoomRepository.get_by_id(target_room.room_id)
	return ApiRoomResponseDto.err("Failed to activate room '%s'" % room_name_dto.string_param)
