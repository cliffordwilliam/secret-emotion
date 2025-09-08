class_name ApiRoomRepository
extends RefCounted


static func create(slot_id: int, room_create_schema: ApiRoomCreateDto) -> ApiRoomResponseDto:
	# OK
	(
		ApiSqlite
		. database
		. insert_row(
			"rooms",
			{
				"slot_id": slot_id,
				"room_name": room_create_schema.room_name,
				"scene_file_path": room_create_schema.scene_file_path,
				"current_room": 1 if room_create_schema.current_room else 0
			},
		)
	)
	return get_by_slot_and_name(slot_id, room_create_schema.room_name)


static func get_by_slot_and_name(slot_id: int, room_name: String) -> ApiRoomResponseDto:
	# OK
	var raw_results: Array[Dictionary] = ApiSqlite.database.select_rows(
		"rooms", "slot_id = %d AND room_name = '%s'" % [slot_id, room_name], ["*"]
	)
	if raw_results.is_empty():
		return ApiRoomResponseDto.err(
			"Slot slot_id %d does not have room '%s' " % [slot_id, room_name]
		)
	return ApiRoomResponseDto.new(raw_results[0])


static func get_current_room(slot_id: int) -> ApiRoomResponseDto:
	# OK
	var raw_results: Array[Dictionary] = ApiSqlite.database.select_rows(
		"rooms", "slot_id = %d AND current_room = 1" % slot_id, ["*"]
	)
	if raw_results.is_empty():
		return ApiRoomResponseDto.err("slot_id %d does not have current room" % slot_id)
	return ApiRoomResponseDto.new(raw_results[0])


static func update(room_id: int, update_data: Dictionary) -> bool:
	# OK
	return ApiSqlite.database.update_rows("rooms", "room_id = %d" % room_id, update_data)


static func get_by_name(room_name: String) -> ApiRoomResponseDto:
	# OK
	var rows: Array[Dictionary] = ApiSqlite.database.select_rows(
		"rooms", "room_name = '%s'" % room_name, ["*"]
	)
	if rows.is_empty():
		return ApiRoomResponseDto.err("Room with name '%s' not found" % room_name)
	return ApiRoomResponseDto.new(rows[0])


static func deactivate_all() -> void:
	# OK
	ApiSqlite.database.update_rows("rooms", "1 = 1", {"current_room": 0})


static func get_by_id(room_id: int) -> ApiRoomResponseDto:
	# OK
	var rows: Array[Dictionary] = ApiSqlite.database.select_rows(
		"rooms", "room_id = %d" % room_id, ["*"]
	)
	if rows.is_empty():
		return ApiRoomResponseDto.err("Room with id '%d' not found" % room_id)
	return ApiRoomResponseDto.new(rows[0])
