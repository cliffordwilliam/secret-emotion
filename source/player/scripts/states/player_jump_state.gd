class_name PlayerJumpState
extends PlayerState
# Player jumping up around


func enter(_previous_state: State) -> void:
	player.play_animation.emit(player_animation_name_data.JUMP)
	player.velocity.y -= player_movement_data.JUMP_SPEED


func physics_process(delta: float) -> void:
	var input_direction_x: int = player_input.get_input_direction_x()

	var speed: float
	if not player_input.is_shift_held():
		speed = player_movement_data.RUN_SPEED
	else:
		speed = player_movement_data.WALK_SPEED

	player.velocity.x = float(input_direction_x) * speed

	var gravity: float
	if player_input.is_jump_held():
		gravity = player_movement_data.NORMAL_GRAVITY
	else:
		gravity = player_movement_data.FALL_GRAVITY

	player.velocity.y += gravity * delta
	player.move_and_slide()

	if player.velocity.x:
		player.face_direction.emit(player.velocity.x < 0.0)

	if player.velocity.y > 0:
		done.emit(player_state_machine.player_fall_state)
