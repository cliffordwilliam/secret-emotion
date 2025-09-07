class_name ApiSlotRepository
extends RefCounted
# Exposed API to access the `slots` table


static func create(slot_create_schema: ApiSlotCreateDto) -> ApiSlotResponseDto:
	ApiSqlite.database.insert_row("slots", slot_create_schema.to_dict())
	return get_by_slot_name(ApiStringParamDto.new(slot_create_schema.slot_name, "slot"))


static func get_by_slot_name(slot_name_schema: ApiStringParamDto) -> ApiSlotResponseDto:
	var raw_results: Array[Dictionary] = ApiSqlite.database.select_rows(
		"slots", "slot_name = '%s'" % slot_name_schema.string_param, ["*"]
	)
	if raw_results.is_empty():
		return _error("Slot with name '%s' is not found" % slot_name_schema.string_param)
	return ApiSlotResponseDto.new(raw_results[0])


static func get_all() -> Array[ApiSlotResponseDto]:
	var sql: String = "SELECT * FROM slots ORDER BY date_created DESC"
	ApiSqlite.database.query(sql)
	return _to_dtos(ApiSqlite.database.query_result)


static func delete(slot_name_schema: ApiStringParamDto) -> ApiSlotResponseDto:
	var existing: ApiSlotResponseDto = get_by_slot_name(slot_name_schema)
	if existing.error:
		return existing
	var rows_deleted: int = ApiSqlite.database.delete_rows(
		"slots", "slot_name = '%s'" % slot_name_schema.string_param
	)
	if rows_deleted > 0:
		return existing
	return _error("Failed to delete slot '%s'" % slot_name_schema.string_param)


static func activate_slot_by_name(slot_name_schema: ApiStringParamDto) -> ApiSlotResponseDto:
	var target_slot: ApiSlotResponseDto = get_by_slot_name(slot_name_schema)
	if target_slot.error:
		return target_slot
	deactivate_all()
	var rows_updated_target: int = (
		ApiSqlite
		. database
		. update_rows(
			"slots",
			"slot_name = '%s'" % target_slot.slot_name,
			{"active_status": 1},
		)
	)
	if rows_updated_target > 0:
		return get_by_slot_name(slot_name_schema)
	return _error("Failed to activate slot '%s'" % slot_name_schema.string_param)


static func deactivate_all() -> void:
	ApiSqlite.database.update_rows("slots", "1 = 1", {"active_status": 0})


static func _error(message: String) -> ApiSlotResponseDto:
	return ApiSlotResponseDto.new({}, message)


static func _to_dtos(raw_rows: Array[Dictionary]) -> Array[ApiSlotResponseDto]:
	var dtos: Array[ApiSlotResponseDto] = []
	for row: Dictionary in raw_rows:
		dtos.append(ApiSlotResponseDto.new(row))
	return dtos
