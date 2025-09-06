class_name APISlotRepository
extends RefCounted


static func create(slot_create_schema: APISlotCreateDTO) -> APISlotResponseDTO:
	ApiSqlite.database.insert_row("slots", slot_create_schema.to_dict())
	return get_by_slot_name(APISlotNameDTO.new(slot_create_schema.slot_name))


static func get_by_slot_name(slot_name_schema: APISlotNameDTO) -> APISlotResponseDTO:
	var raw_results: Array[Dictionary] = ApiSqlite.database.select_rows(
		"slots", "slot_name = '%s'" % slot_name_schema.slot_name, ["*"]
	)
	if raw_results.is_empty():
		return _error("Slot with name '%s' is not found" % slot_name_schema.slot_name)
	return APISlotResponseDTO.new(raw_results[0])


static func get_all() -> Array[APISlotResponseDTO]:
	var sql: String = "SELECT * FROM slots ORDER BY date_created DESC"
	ApiSqlite.database.query(sql)
	return _to_dtos(ApiSqlite.database.query_result)


static func delete(slot_name_schema: APISlotNameDTO) -> APISlotResponseDTO:
	var existing: APISlotResponseDTO = get_by_slot_name(slot_name_schema)
	if existing.error:
		return existing
	var rows_deleted: int = ApiSqlite.database.delete_rows(
		"slots", "slot_name = '%s'" % slot_name_schema.slot_name
	)
	if rows_deleted > 0:
		return existing
	return _error("Failed to delete slot '%s'" % slot_name_schema.slot_name)


static func activate_slot_by_name(slot_name_schema: APISlotNameDTO) -> APISlotResponseDTO:
	var target_slot: APISlotResponseDTO = get_by_slot_name(slot_name_schema)
	if target_slot.error:
		return target_slot
	deactivate_all()
	var rows_updated_target: int = (
		ApiSqlite
		. database
		. update_rows(
			"slots",
			"slot_name = '%s'" % target_slot.slot_name,
			{"active_status": 1, "date_modified": "datetime('now')"},
		)
	)
	if rows_updated_target > 0:
		return get_by_slot_name(slot_name_schema)
	return _error("Failed to activate slot '%s'" % slot_name_schema.slot_name)


static func deactivate_all() -> void:
	ApiSqlite.database.update_rows(
		"slots", "1 = 1", {"active_status": 0, "date_modified": "datetime('now')"}
	)


static func _error(message: String) -> APISlotResponseDTO:
	return APISlotResponseDTO.new({}, message)


static func _to_dtos(raw_rows: Array[Dictionary]) -> Array[APISlotResponseDTO]:
	var dtos: Array[APISlotResponseDTO] = []
	for row: Dictionary in raw_rows:
		dtos.append(APISlotResponseDTO.new(row))
	return dtos
