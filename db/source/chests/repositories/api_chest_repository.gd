class_name ApiChestRepository
extends RefCounted


static func create(room_id: int, chest_create_schema: ApiChestCreateDto) -> ApiChestResponseDto:
	var insert_data: Dictionary = {
		"room_id": room_id,
		"chest_name": chest_create_schema.chest_name,
		"current_state": chest_create_schema.chest_state,
	}
	ApiSqlite.database.insert_row("chests", insert_data)
	return get_by_room_and_name(room_id, chest_create_schema.chest_name)


static func update(room_id: int, chest_edit_schema: ApiChestEditDto) -> ApiChestResponseDto:
	var where: String = (
		"room_id = %d AND chest_name = '%s'" % [room_id, chest_edit_schema.chest_name]
	)
	var edit_data: Dictionary = {
		"room_id": room_id,
		"chest_name": chest_edit_schema.chest_name,
		"current_state": chest_edit_schema.chest_state,
	}
	var rows_updated: int = ApiSqlite.database.update_rows("chests", where, edit_data)
	if rows_updated == 0:
		return ApiChestResponseDto.new({}, "No chest updated")
	return get_by_room_and_name(room_id, chest_edit_schema.chest_name)


static func get_by_room_and_name(room_id: int, chest_name: String) -> ApiChestResponseDto:
	var where: String = "room_id = %d AND chest_name = '%s'" % [room_id, chest_name]
	var raw_results: Array[Dictionary] = ApiSqlite.database.select_rows("chests", where, ["*"])
	if raw_results.is_empty():
		return ApiChestResponseDto.new({}, "Chest not found")
	return ApiChestResponseDto.new(raw_results[0])
