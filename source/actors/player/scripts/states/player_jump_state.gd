class_name PlayerJumpState
extends PlayerState


func enter(_previous_state: State) -> void:
	player_animation_sprite.play(PlayerAnimationNameData.JUMP)
	player.velocity.y -= PlayerMovementData.JUMP_SPEED
	SoundEffect.play(SoundEffectFilePathConstants.PLAYER_JUMP)


func physics_process(delta: float) -> void:
	var input_direction_x: int = player_input.get_input_direction_x()

	var speed: float
	if not player_input.is_shift_held():
		speed = PlayerMovementData.RUN_SPEED
	else:
		speed = PlayerMovementData.WALK_SPEED

	player.velocity.x = float(input_direction_x) * speed

	var gravity: float
	if player_input.is_jump_held():
		gravity = PlayerMovementData.NORMAL_GRAVITY
	else:
		gravity = PlayerMovementData.FALL_GRAVITY

	player.velocity.y += gravity * delta
	player.velocity.y = min(player.velocity.y, PlayerMovementData.MAX_FALL_SPEED)
	player.move_and_slide()

	if player.velocity.x:
		player_animation_sprite.set_face_direction(player.velocity.x < 0.0)

	if not player.velocity.y < 0:
		done.emit(player_state_machine.player_fall_state)
