class_name PlayerRunState
extends PlayerState
# Player running around


func enter(_previous_state: State) -> void:
	player.play_animation.emit(player.animation_name_data.TO_RUN)


func physics_process(_delta: float) -> void:
	var input_direction_x: int = player_input.get_input_direction_x()

	if not input_direction_x:
		done.emit(player_state_machine.player_idle_state)
		return

	if not player_input.is_shift_held():
		done.emit(player_state_machine.player_walk_state)
		return

	player.velocity.x = float(input_direction_x) * player.movement_data.RUN_SPEED
	player.move_and_slide()

	player.face_direction.emit(player.velocity.x < 0.0)
