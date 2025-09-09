class_name ApiPlayerService
extends RefCounted


static func create(
	slot_name: ApiStringParamDto, player_create_dto: ApiPlayerCreateDto
) -> ApiPlayerResponseDto:
	var slot: ApiSlotResponseDto = ApiSlotRepository.get_by_name(slot_name.string_param)
	if slot.error:
		return ApiPlayerResponseDto.err("Slot '%s' not found" % slot_name.string_param)
	var existing_player: ApiPlayerResponseDto = ApiPlayerRepository.get_by_slot_id(slot.slot_id)
	if not existing_player.error:
		return ApiPlayerResponseDto.err(
			"Slot '%s' already have a player" % [slot_name.string_param]
		)
	return ApiPlayerRepository.create(slot.slot_id, player_create_dto)


static func get_by_slot_id(slot_name_dto: ApiStringParamDto) -> ApiPlayerResponseDto:
	var slot: ApiSlotResponseDto = ApiSlotRepository.get_by_name(slot_name_dto.string_param)
	if slot.error:
		return ApiPlayerResponseDto.err("Slot '%s' not found" % slot_name_dto.string_param)
	return ApiPlayerRepository.get_by_slot_id(slot.slot_id)


static func update_by_slot_id(
	slot_name_dto: ApiStringParamDto, player_edit_dto: ApiPlayerEditDto
) -> ApiPlayerResponseDto:
	var slot: ApiSlotResponseDto = ApiSlotRepository.get_by_name(slot_name_dto.string_param)
	if slot.error:
		return ApiPlayerResponseDto.err("Slot '%s' not found" % slot_name_dto.string_param)
	return (
		ApiPlayerRepository
		. update(
			slot.slot_id,
			(
				ApiPlayerEditDto
				. new(
					{
						"player_pos_x": player_edit_dto.player_pos_x,
						"player_pos_y": player_edit_dto.player_pos_y,
						"flip_h": player_edit_dto.flip_h,
					}
				)
			)
		)
	)
