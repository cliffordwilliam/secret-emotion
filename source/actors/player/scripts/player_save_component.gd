class_name PlayerSaveComponent
extends SaveComponent

@onready var player: Player = owner as Player


func read_world_state() -> void:
	await player.ready

	var raw_data: Dictionary = get_world_state()

	if raw_data.is_empty():
		data_loaded.emit()
		return

	_rehydrate(_to_dto(raw_data))
	data_loaded.emit()


func _rehydrate(save_data: PlayerSaveData) -> void:
	player.position.x = save_data.position_x
	player.position.y = save_data.position_y
	player.player_animated_sprite.flip_h = save_data.flip_h


func dump_state_to_world() -> void:
	var save_data: PlayerSaveData = PlayerSaveData.new()
	save_data.position_x = player.position.x
	save_data.position_y = player.position.y
	save_data.flip_h = player.player_animated_sprite.flip_h
	update_world_state(_to_raw(save_data))


func _to_dto(raw_data: Dictionary) -> PlayerSaveData:
	var save_data: PlayerSaveData = PlayerSaveData.new()
	save_data.flip_h = raw_data[PlayerSaveData.KEY_FLIP_H] == "true"
	save_data.position_x = raw_data[PlayerSaveData.KEY_POSITION_X].to_float()
	save_data.position_y = raw_data[PlayerSaveData.KEY_POSITION_Y].to_float()
	return save_data


func _to_raw(save_data: PlayerSaveData) -> Dictionary:
	return {
		PlayerSaveData.KEY_FLIP_H: str(save_data.flip_h),
		PlayerSaveData.KEY_POSITION_X: str(save_data.position_x),
		PlayerSaveData.KEY_POSITION_Y: str(save_data.position_y),
	}
