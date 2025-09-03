class_name PlayerFallState
extends PlayerState
# Player falling down around


func enter(_previous_state: State) -> void:
	player_animation_sprite.play(player_animation_name_data.TO_FALL)


func exit() -> void:
	SoundEffect.play(SoundEffectFilePathContants.SOFT_LAND)


func physics_process(delta: float) -> void:
	var input_direction_x: int = player_input.get_input_direction_x()

	var speed: float
	if not player_input.is_shift_held():
		speed = player_movement_data.RUN_SPEED
	else:
		speed = player_movement_data.WALK_SPEED

	player.velocity.x = float(input_direction_x) * speed
	player.velocity.y += player_movement_data.FALL_GRAVITY * delta
	player.velocity.y = min(player.velocity.y, player_movement_data.MAX_FALL_SPEED)
	player.move_and_slide()

	if player.velocity.x:
		player_animation_sprite.set_face_direction(player.velocity.x < 0.0)

	if player.is_on_floor():
		if player_input.is_down_held():
			done.emit(player_state_machine.player_crouch_state)
			return

		if player_input.is_jump_tapped():
			done.emit(player_state_machine.player_jump_state)
			return

		if not player_input.get_input_direction_x():
			done.emit(player_state_machine.player_idle_state)
			return

		if player_input.get_input_direction_x() and player_input.is_shift_held():
			done.emit(player_state_machine.player_walk_state)
			return

		if player_input.get_input_direction_x():
			done.emit(player_state_machine.player_run_state)
			return
