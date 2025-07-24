class_name PlayerWalkState
extends PlayerState
# Player walking around


func enter(_previous_state: State) -> void:
	player.play_animation.emit(player_animation_name_data.WALK)


func physics_process(_delta: float) -> void:
	var input_direction_x: int = player_input.get_input_direction_x()

	if player_input.is_down_held():
		done.emit(player_state_machine.player_crouch_state)
		return

	if player_input.is_jump_tapped():
		done.emit(player_state_machine.player_jump_state)
		return

	if not input_direction_x:
		done.emit(player_state_machine.player_idle_state)
		return

	if not player_input.is_shift_held():
		done.emit(player_state_machine.player_run_state)
		return

	player.velocity.x = float(input_direction_x) * player_movement_data.WALK_SPEED
	player.move_and_slide()

	if not player.is_on_floor():
		done.emit(player_state_machine.player_fall_state)
		return

	player.face_direction.emit(player.velocity.x < 0.0)
