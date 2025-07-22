class_name PlayerWalkState
extends PlayerState
# Player walking around


func enter() -> void:
	player.play_animation.emit(player.animation_name_data.WALK)


func physics_process(_delta: float) -> void:
	var input_direction_x: int = player_input.get_input_direction_x()

	player.velocity.x = float(input_direction_x) * player.movement_data.WALK_SPEED
	player.move_and_slide()

	if not input_direction_x:
		done.emit(player_state_machine.player_idle_state)
		return

	player.face_direction.emit(player.velocity.x < 0.0)
