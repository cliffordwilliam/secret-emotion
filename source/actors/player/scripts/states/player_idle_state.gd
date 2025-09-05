class_name PlayerIdleState
extends PlayerState
# Player standing still


func enter(previous_state: State) -> void:
	# TODO: Make strat here
	if previous_state == player_state_machine.player_run_state:
		player_animation_sprite.play(PlayerAnimationNameData.RUN_TO_IDLE)
	elif previous_state == player_state_machine.player_crouch_state:
		player_animation_sprite.play(PlayerAnimationNameData.CROUCH_TO_IDLE)
	elif previous_state == player_state_machine.player_fall_state:
		player_animation_sprite.play(PlayerAnimationNameData.FALL_TO_IDLE)
	else:
		player_animation_sprite.play(PlayerAnimationNameData.IDLE)
	player.velocity.x = 0.0


func physics_process(_delta: float) -> void:
	# TODO: Make strat here
	if player_input.is_down_held():
		done.emit(player_state_machine.player_crouch_state)
		return

	if player_input.is_jump_tapped():
		done.emit(player_state_machine.player_jump_state)
		return

	if player_input.get_input_direction_x() and player_input.is_shift_held():
		done.emit(player_state_machine.player_walk_state)
		return

	if player_input.get_input_direction_x():
		done.emit(player_state_machine.player_run_state)
		return
