class_name ApiPlayerRepository
extends RefCounted


static func create(slot_id: int, player_create_dto: ApiPlayerCreateDto) -> ApiPlayerResponseDto:
	(
		ApiSqlite
		. database
		. insert_row(
			"player",
			{
				"slot_id": slot_id,
				"pos_x": player_create_dto.player_pos_x,
				"pos_y": player_create_dto.player_pos_y,
				"flip_h": player_create_dto.flip_h,
			},
		)
	)
	return get_by_slot_id(slot_id)


static func update(slot_id: int, player_edit_schema: ApiPlayerEditDto) -> ApiPlayerResponseDto:
	var rows_updated: int = (
		ApiSqlite
		. database
		. update_rows(
			"player",
			"slot_id = %d" % [slot_id],
			{
				"pos_x": player_edit_schema.player_pos_x,
				"pos_y": player_edit_schema.player_pos_y,
				"flip_h": player_edit_schema.flip_h,
			},
		)
	)
	if rows_updated == 0:
		return ApiPlayerResponseDto.new({}, "No player updated")
	return get_by_slot_id(slot_id)


static func get_by_slot_id(slot_id: int) -> ApiPlayerResponseDto:
	var raw_results: Array[Dictionary] = ApiSqlite.database.select_rows(
		"player", "slot_id = %d" % [slot_id], ["*"]
	)
	if raw_results.is_empty():
		return ApiPlayerResponseDto.err("Slot slot_id %d does not have a player" % [slot_id])
	return ApiPlayerResponseDto.new(raw_results[0])
