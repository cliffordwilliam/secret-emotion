class_name PlayerWalkState
extends PlayerState

@onready var walk_step_sfx_timer: Timer = $WalkStepSfxTimer


func enter(_previous_state: State) -> void:
	player_animation_sprite.play(PlayerAnimationNameData.WALK)
	walk_step_sfx_timer.timeout.connect(_on_walk_step_sfx_timer_timeout)
	walk_step_sfx_timer.wait_time = PlayerSoundEffectData.WALK_STEP_SECONDS_INTERVAL
	walk_step_sfx_timer.start()


func exit() -> void:
	walk_step_sfx_timer.timeout.disconnect(_on_walk_step_sfx_timer_timeout)
	walk_step_sfx_timer.stop()


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

	player.velocity.x = float(input_direction_x) * PlayerMovementData.WALK_SPEED
	player.move_and_slide()

	if not player.is_on_floor():
		done.emit(player_state_machine.player_fall_state)
		return

	player_animation_sprite.set_face_direction(player.velocity.x < 0.0)


func _on_walk_step_sfx_timer_timeout() -> void:
	SoundEffect.play(SoundEffectFilePathConstants.PLAYER_GRASS_FOOTSTEP)
