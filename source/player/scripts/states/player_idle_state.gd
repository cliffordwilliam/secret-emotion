class_name PlayerIdleState
extends PlayerState
# Player standing still


func enter(previous_state: State) -> void:
	if previous_state == player_state_machine.player_run_state:
		player.play_animation.emit(player.animation_name_data.RUN_TO_IDLE)
	elif previous_state == player_state_machine.player_crouch_state:
		player.play_animation.emit(player.animation_name_data.CROUCH_TO_IDLE)
	else:
		player.play_animation.emit(player.animation_name_data.IDLE)
	player.velocity.x = 0.0


func physics_process(_delta: float) -> void:
	if player_input.get_input_direction_x():
		done.emit(player_state_machine.player_walk_state)
		return

	if player_input.is_down_held():
		done.emit(player_state_machine.player_crouch_state)
		return
