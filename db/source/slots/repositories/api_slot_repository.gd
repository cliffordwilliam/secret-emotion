class_name ApiSlotRepository
extends RefCounted


static func create(insert_data: Dictionary) -> ApiSlotResponseDto:
	ApiSqlite.database.insert_row("slots", insert_data)
	return get_by_id(ApiSqlite.database.get_last_insert_rowid())


static func get_by_id(slot_id: int) -> ApiSlotResponseDto:
	var rows: Array[Dictionary] = ApiSqlite.database.select_rows(
		"slots", "slot_id = %d" % slot_id, ["*"]
	)
	if rows.is_empty():
		return _error("Slot with id '%d' not found" % slot_id)
	return ApiSlotResponseDto.new(rows[0])


static func get_by_name(slot_name: String) -> ApiSlotResponseDto:
	var rows: Array[Dictionary] = ApiSqlite.database.select_rows(
		"slots", "slot_name = '%s'" % slot_name, ["*"]
	)
	if rows.is_empty():
		return _error("Slot with name '%s' not found" % slot_name)
	return ApiSlotResponseDto.new(rows[0])


static func get_active_slot() -> ApiSlotResponseDto:
	# OK
	var rows: Array[Dictionary] = ApiSqlite.database.select_rows(
		"slots", "active_status = 1", ["*"]
	)
	if rows.is_empty():
		return _error("No active slot found")
	return ApiSlotResponseDto.new(rows[0])


static func get_all() -> Array[ApiSlotResponseDto]:
	var sql: String = "SELECT * FROM slots ORDER BY date_created DESC"
	ApiSqlite.database.query(sql)
	return _to_dtos(ApiSqlite.database.query_result)


static func delete_by_id(slot_id: int) -> bool:
	return ApiSqlite.database.delete_rows("slots", "slot_id = %d" % slot_id)


static func update(slot_id: int, update_data: Dictionary) -> bool:
	return ApiSqlite.database.update_rows("slots", "slot_id = %d" % slot_id, update_data)


static func deactivate_all() -> void:
	ApiSqlite.database.update_rows("slots", "1 = 1", {"active_status": 0})


static func _error(message: String) -> ApiSlotResponseDto:
	return ApiSlotResponseDto.new({}, message)


static func _to_dtos(raw_rows: Array[Dictionary]) -> Array[ApiSlotResponseDto]:
	var dtos: Array[ApiSlotResponseDto] = []
	for row: Dictionary in raw_rows:
		dtos.append(ApiSlotResponseDto.new(row))
	return dtos
