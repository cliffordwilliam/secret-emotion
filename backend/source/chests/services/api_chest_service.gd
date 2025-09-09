class_name ApiChestService
extends RefCounted


static func get_by_slot_name_room_name_and_chest_name(
	slot_name: ApiStringParamDto, room_name: ApiStringParamDto, chest_name: ApiStringParamDto
) -> ApiChestResponseDto:
	var slot: ApiSlotResponseDto = ApiSlotRepository.get_by_name(slot_name.string_param)
	if slot.error:
		return ApiChestResponseDto.err("Slot '%s' not found" % slot_name.string_param)
	var room: ApiRoomResponseDto = ApiRoomRepository.get_by_name_and_slot_id(
		room_name.string_param, slot.slot_id
	)
	if room.error:
		return ApiChestResponseDto.err("Room '%s' not found" % room_name.string_param)
	return ApiChestRepository.get_by_slot_id_and_room_id_and_name(
		slot.slot_id, room.room_id, chest_name.string_param
	)


static func update(
	slot_name: ApiStringParamDto, room_name: ApiStringParamDto, chest_edit_dto: ApiChestEditDto
) -> ApiChestResponseDto:
	var slot: ApiSlotResponseDto = ApiSlotRepository.get_by_name(slot_name.string_param)
	if slot.error:
		return ApiChestResponseDto.err("Slot '%s' not found" % slot_name.string_param)
	var room: ApiRoomResponseDto = ApiRoomRepository.get_by_name_and_slot_id(
		room_name.string_param, slot.slot_id
	)
	if room.error:
		return ApiChestResponseDto.err("Room '%s' not found" % room_name.string_param)
	return (
		ApiChestRepository
		. update(
			slot.slot_id,
			room.room_id,
			(
				ApiChestEditDto
				. new(
					{
						"chest_name": chest_edit_dto.chest_name,
						"chest_state": chest_edit_dto.chest_state,
					}
				)
			)
		)
	)


static func create(
	slot_name: ApiStringParamDto, room_name: ApiStringParamDto, chest_create_dto: ApiChestCreateDto
) -> ApiChestResponseDto:
	var slot: ApiSlotResponseDto = ApiSlotRepository.get_by_name(slot_name.string_param)
	if slot.error:
		return ApiChestResponseDto.err("Slot '%s' not found" % slot_name.string_param)
	var room: ApiRoomResponseDto = ApiRoomRepository.get_by_name_and_slot_id(
		room_name.string_param, slot.slot_id
	)
	if room.error:
		return ApiChestResponseDto.err("Room '%s' not found" % room_name.string_param)
	var existing: ApiChestResponseDto = ApiChestRepository.get_by_slot_id_and_room_id_and_name(
		slot.slot_id, room.room_id, chest_create_dto.chest_name
	)
	if not existing.error:
		return ApiChestResponseDto.err(
			(
				"Chest '%s' already exists in room '%s' (slot '%s')"
				% [chest_create_dto.chest_name, room.room_name, slot.slot_name]
			)
		)
	return (
		ApiChestRepository
		. create(
			slot.slot_id,
			room.room_id,
			(
				ApiChestCreateDto
				. new(
					{
						"chest_name": chest_create_dto.chest_name,
						"chest_state": chest_create_dto.chest_state,
					}
				)
			),
		)
	)
