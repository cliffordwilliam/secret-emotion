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

	# Fetch from DB via service

	var player_data: ApiPlayerResponseDto = ApiPlayerService.get_in_current_context()
	if player_data.error:
		# No save exists yet → start fresh AND make my new save
		(
			ApiPlayerService
			. create_in_current_context(
				(
					ApiPlayerCreateDto
					. new(
						{
							"player_pos_x": player.position.x,
							"player_pos_y": player.position.x,
							"flip_h": player.player_animated_sprite.flip_h,
						}
					)
				)
			)
		)
		properties_initialized_by_save_file.emit()
		return

	# Rehydrate self using DB DTO
	_rehydrate_self_with_loaded_data(player_data)
	# Start state machine now
	properties_initialized_by_save_file.emit()


func _rehydrate_self_with_loaded_data(player_data: ApiPlayerResponseDto) -> void:
	player.position.x = player_data.pos_x
	player.position.y = player_data.pos_y
	player.player_animated_sprite.flip_h = player_data.flip_h


func dump_state_to_world() -> void:
	var result: ApiPlayerResponseDto = (
		ApiPlayerService
		. update_in_current_context(
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
