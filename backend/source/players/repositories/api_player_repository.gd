class_name ApiPlayerRepository
extends RefCounted


static func create(slot_id: int, player_create_schema: ApiPlayerCreateDto) -> ApiPlayerResponseDto:
	# OK
	(
		ApiSqlite
		. database
		. insert_row(
			"player",
			{
				"slot_id": slot_id,
				"pos_x": player_create_schema.player_pos_x,
				"pos_y": player_create_schema.player_pos_y,
				"flip_h": player_create_schema.flip_h,
			},
		)
	)
	return get_by_slot_id(slot_id)


static func update(slot_id: int, player_edit_schema: ApiPlayerEditDto) -> ApiPlayerResponseDto:
	# OK
	var rows_updated: int = (
		ApiSqlite
		. database
		. update_rows(
			"player",
			"slot_id = %d" % [slot_id],
			{
				"slot_id": slot_id,
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
	# OK
	var where: String = "slot_id = %d" % [slot_id]
	var raw_results: Array[Dictionary] = ApiSqlite.database.select_rows("player", where, ["*"])
	if raw_results.is_empty():
		return ApiPlayerResponseDto.new({}, "Player not found for slot with id: %s" % [slot_id])
	return ApiPlayerResponseDto.new(raw_results[0])
