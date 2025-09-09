class_name PlayerSaveComponent
extends SaveComponent
# This is an extension of owner. It stores owner belongings
# Determine when to start owner state machine

var player: Player


func _kid_ready() -> void:
	# Called after parent ready
	player = owner as Player


func read_world_state() -> void:
	# This func is responsible for starting state machine
	# So must ensure parent refs are ready in state base class
	await player.ready

	# Fetch data from db
	var found_active_slot: ApiSlotResponseDto = ApiSlotService.get_active_slot()
	if found_active_slot.error:
		#ToastMaker.show_toast(found_active_slot.error_message)
		return
	#ToastMaker.show_toast(
	#"Found active slot '%s'" % found_active_slot.slot_name
	#)
	var player_data: ApiPlayerResponseDto = ApiPlayerService.get_by_slot_id(
		ApiStringParamDto.new(found_active_slot.slot_name)
	)
	# Slot and player are one to one, so player must exists
	if player_data.error:
		#ToastMaker.show_toast(found_active_slot.error_message)
		return
	# Rehydrate self using DB DTO
	_rehydrate_self_with_loaded_data(player_data)
	# Start state machine now
	properties_initialized_by_save_file.emit()


func _rehydrate_self_with_loaded_data(player_data: ApiPlayerResponseDto) -> void:
	player.position.x = player_data.pos_x
	player.position.y = player_data.pos_y
	player.player_animated_sprite.flip_h = player_data.flip_h


func dump_state_to_world(slot_name: String = "") -> void:
	var found_slot: ApiSlotResponseDto
	if slot_name.strip_edges() != "":
		found_slot = ApiSlotService.get_by_name(slot_name)
	else:
		found_slot = ApiSlotService.get_active_slot()
	if found_slot.error:
		return
	var result: ApiPlayerResponseDto = (
		ApiPlayerService
		. update_by_slot_id(
			ApiStringParamDto.new(found_slot.slot_name),
			(
				ApiPlayerEditDto
				. new(
					{
						"player_pos_x": player.position.x,
						"player_pos_y": player.position.y,
						"flip_h": player.player_animated_sprite.flip_h,
					}
				)
			)
		)
	)
	if result.error:
		push_error("Failed to persist player '%s': %s" % [player.name, result.error_message])
