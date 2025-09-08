class_name ApiRoomService
extends RefCounted


static func create(room_create_dto: ApiRoomCreateDto) -> ApiRoomResponseDto:
	# OK
	var slot: ApiSlotResponseDto = ApiSlotRepository.get_by_name(room_create_dto.slot_name)
	if slot.error:
		return ApiRoomResponseDto.err("Slot '%s' not found" % room_create_dto.slot_name)

	var existing_room: ApiRoomResponseDto = ApiRoomRepository.get_by_slot_and_name(
		slot.slot_id, room_create_dto.room_name
	)
	if not existing_room.error:  # not existing_room.error means we found a room
		return ApiRoomResponseDto.err(
			(
				"Room name '%s' is already taken for slot '%s'"
				% [room_create_dto.room_name, room_create_dto.slot_name]
			)
		)

	return ApiRoomRepository.create(slot.slot_id, room_create_dto)


static func get_current_room(slot_name_dto: ApiStringParamDto) -> ApiRoomResponseDto:
	# OK
	var slot: ApiSlotResponseDto = ApiSlotRepository.get_by_name(slot_name_dto.string_param)
	if slot.error:
		return ApiRoomResponseDto.err("Slot '%s' not found" % slot_name_dto.string_param)

	return ApiRoomRepository.get_current_room(slot.slot_id)


static func set_room_to_current_by_name(room_name_dto: ApiStringParamDto) -> ApiRoomResponseDto:
	# OK
	var target_room: ApiRoomResponseDto = ApiRoomRepository.get_by_name(room_name_dto.string_param)
	if target_room.error:
		return target_room

	if target_room.current_room:
		return target_room

	ApiRoomRepository.deactivate_all()
	if ApiRoomRepository.update(target_room.room_id, {"current_room": 1}):
		return ApiRoomRepository.get_by_id(target_room.room_id)

	return ApiRoomResponseDto.err(
		"Failed to set current for room '%s'" % room_name_dto.string_param
	)


static func create_new_current_room_in_current_context(
	room_context_create_dto: ApiRoomContextCreateDto
) -> ApiRoomResponseDto:
	# OK
	var active_slot: ApiSlotResponseDto = ApiSlotRepository.get_active_slot()
	if not active_slot:
		return ApiRoomResponseDto.err("No active slot found")

	var existing: ApiRoomResponseDto = ApiRoomRepository.get_by_name(
		room_context_create_dto.room_name
	)
	if not existing.error:
		return ApiRoomResponseDto.err(
			(
				"Room name '%s' already exists in current active slot '%s'"
				% [room_context_create_dto.room_name, active_slot.slot_name]
			)
		)

	if room_context_create_dto.current_room:
		ApiRoomRepository.deactivate_all()

	return (
		ApiRoomRepository
		. create(
			active_slot.slot_id,
			(
				ApiRoomCreateDto
				. new(
					{
						"slot_name": active_slot.slot_name,
						"room_name": room_context_create_dto.room_name,
						"scene_file_path": room_context_create_dto.scene_file_path,
						"current_room": room_context_create_dto.current_room,
					}
				)
			),
		)
	)
