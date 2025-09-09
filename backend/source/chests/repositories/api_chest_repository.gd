class_name ApiChestRepository
extends RefCounted


static func create(
	slot_id: int, room_id: int, chest_create_dto: ApiChestCreateDto
) -> ApiChestResponseDto:
	(
		ApiSqlite
		. database
		. insert_row(
			"chests",
			{
				"slot_id": slot_id,
				"room_id": room_id,
				"chest_name": chest_create_dto.chest_name,
				"current_state": chest_create_dto.chest_state,
			},
		)
	)
	return get_by_slot_id_and_room_id_and_name(slot_id, room_id, chest_create_dto.chest_name)


static func update(
	slot_id: int, room_id: int, chest_edit_schema: ApiChestEditDto
) -> ApiChestResponseDto:
	var rows_updated: int = (
		ApiSqlite
		. database
		. update_rows(
			"chests",
			(
				"slot_id = %d AND room_id = %d AND chest_name = '%s'"
				% [slot_id, room_id, chest_edit_schema.chest_name]
			),
			{
				"slot_id": slot_id,
				"room_id": room_id,
				"chest_name": chest_edit_schema.chest_name,
				"current_state": chest_edit_schema.chest_state,
			},
		)
	)
	if rows_updated == 0:
		return ApiChestResponseDto.new({}, "No chest updated for given slot and room")
	return get_by_slot_id_and_room_id_and_name(slot_id, room_id, chest_edit_schema.chest_name)


static func get_by_slot_id_and_room_id_and_name(
	slot_id: int, room_id: int, chest_name: String
) -> ApiChestResponseDto:
	var raw_results: Array[Dictionary] = ApiSqlite.database.select_rows(
		"chests",
		"slot_id = %d AND room_id = %d AND chest_name = '%s'" % [slot_id, room_id, chest_name],
		["*"]
	)
	if raw_results.is_empty():
		return ApiChestResponseDto.new({}, "Chest not found in given slot and room")
	return ApiChestResponseDto.new(raw_results[0])
