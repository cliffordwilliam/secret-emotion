class_name ApiRoomRepository
extends RefCounted


static func create(slot_id: int, room_create_schema: ApiRoomCreateDto) -> ApiRoomResponseDto:
	(
		ApiSqlite
		. database
		. insert_row(
			"rooms",
			{
				"slot_id": slot_id,
				"room_name": room_create_schema.room_name,
				"scene_file_path": room_create_schema.scene_file_path,
				"active_status": 1 if room_create_schema.active_status else 0
			},
		)
	)
	return get_by_slot_id_and_name(slot_id, room_create_schema.room_name)


static func get_by_slot_id_and_name(slot_id: int, room_name: String) -> ApiRoomResponseDto:
	var raw_results: Array[Dictionary] = ApiSqlite.database.select_rows(
		"rooms", "slot_id = %d AND room_name = '%s'" % [slot_id, room_name], ["*"]
	)
	if raw_results.is_empty():
		return ApiRoomResponseDto.err(
			"Slot slot_id %d does not have room '%s' " % [slot_id, room_name]
		)
	return ApiRoomResponseDto.new(raw_results[0])


static func get_active_room_by_slot_id(slot_id: int) -> ApiRoomResponseDto:
	var raw_results: Array[Dictionary] = ApiSqlite.database.select_rows(
		"rooms", "slot_id = %d AND active_status = 1" % slot_id, ["*"]
	)
	if raw_results.is_empty():
		return ApiRoomResponseDto.err("slot_id %d does not have any active room" % slot_id)
	return ApiRoomResponseDto.new(raw_results[0])


static func activate_by_id(room_id: int) -> bool:
	return ApiSqlite.database.update_rows("rooms", "room_id = %d" % room_id, {"active_status": 1})


static func get_by_name_and_slot_id(room_name: String, slot_id: int) -> ApiRoomResponseDto:
	var rows: Array[Dictionary] = ApiSqlite.database.select_rows(
		"rooms", "room_name = '%s' AND slot_id = %d" % [room_name, slot_id], ["*"]
	)
	if rows.is_empty():
		return ApiRoomResponseDto.err("Room with name '%s' not found" % room_name)
	return ApiRoomResponseDto.new(rows[0])


static func deactivate_all_by_slot_id(slot_id: int) -> void:
	ApiSqlite.database.update_rows("rooms", "slot_id = %d" % [slot_id], {"active_status": 0})


static func get_by_id(room_id: int) -> ApiRoomResponseDto:
	var rows: Array[Dictionary] = ApiSqlite.database.select_rows(
		"rooms", "room_id = %d" % room_id, ["*"]
	)
	if rows.is_empty():
		return ApiRoomResponseDto.err("Room with id '%d' not found" % room_id)
	return ApiRoomResponseDto.new(rows[0])
