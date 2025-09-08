class_name ApiPlayerService
extends RefCounted


static func get_in_current_context() -> ApiPlayerResponseDto:
	var active_slot: ApiSlotResponseDto = ApiSlotRepository.get_active_slot()
	if not active_slot:
		return ApiPlayerResponseDto.err("No active slot found")

	return ApiPlayerRepository.get_by_slot_id(active_slot.slot_id)


static func update_in_current_context(player_edit_dto: ApiPlayerEditDto) -> ApiPlayerResponseDto:
	var active_slot: ApiSlotResponseDto = ApiSlotRepository.get_active_slot()
	if not active_slot:
		return ApiPlayerResponseDto.err("No active slot found")

	return (
		ApiPlayerRepository
		. update(
			active_slot.slot_id,
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


static func create_in_current_context(
	player_create_dto: ApiPlayerCreateDto
) -> ApiPlayerResponseDto:
	var active_slot: ApiSlotResponseDto = ApiSlotRepository.get_active_slot()
	if not active_slot:
		return ApiPlayerResponseDto.err("No active slot found")

	var existing: ApiPlayerResponseDto = ApiPlayerRepository.get_by_slot_id(active_slot.slot_id)
	if not existing.error:
		return ApiPlayerResponseDto.err(
			"Player already exists in slot '%s'" % [active_slot.slot_name]
		)

	return (
		ApiPlayerRepository
		. create(
			active_slot.slot_id,
			(
				ApiPlayerCreateDto
				. new(
					{
						"player_pos_x": player_create_dto.player_pos_x,
						"player_pos_y": player_create_dto.player_pos_y,
						"flip_h": player_create_dto.flip_h,
					}
				)
			)
		)
	)
