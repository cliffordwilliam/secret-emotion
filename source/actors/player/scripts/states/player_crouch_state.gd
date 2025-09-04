class_name PlayerCrouchState
extends PlayerState
# Player crouching still


func enter(_previous_state: State) -> void:
	player_animation_sprite.play(player_animation_name_data.TO_CROUCH)
	player.velocity.x = 0.0


func physics_process(_delta: float) -> void:
	if player_input.is_jump_tapped():
		done.emit(player_state_machine.player_jump_state)
		return

	if not player_input.is_down_held():
		# TODO: Make strat here
		if not player_input.get_input_direction_x():
			done.emit(player_state_machine.player_idle_state)
			return

		if player_input.get_input_direction_x() and player_input.is_shift_held():
			done.emit(player_state_machine.player_walk_state)
			return

		if player_input.get_input_direction_x():
			done.emit(player_state_machine.player_run_state)
			return
