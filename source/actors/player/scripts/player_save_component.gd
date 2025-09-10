class_name PlayerSaveComponent
extends SaveComponent

@onready var player: Player = owner as Player


func read_world_state() -> void:
	await player.ready
	var raw_data: Dictionary = get_world_state()
	if raw_data.is_empty():
		finished_reading.emit()
		return
	_rehydrate(raw_data)
	finished_reading.emit()


func _rehydrate(raw_data: Dictionary) -> void:
	player.player_animated_sprite.flip_h = raw_data[PlayerSaveDataKeys.KEY_FLIP_H] == "true"
	player.position.x = raw_data[PlayerSaveDataKeys.KEY_POSITION_X].to_float()
	player.position.y = raw_data[PlayerSaveDataKeys.KEY_POSITION_Y].to_float()


func dump_state_to_world() -> void:
	update_world_state(
		{
			PlayerSaveDataKeys.KEY_FLIP_H: str(player.player_animated_sprite.flip_h),
			PlayerSaveDataKeys.KEY_POSITION_X: str(player.position.x),
			PlayerSaveDataKeys.KEY_POSITION_Y: str(player.position.y),
		}
	)
