class_name PlayerWalkState
extends PlayerState


func enter() -> void:
	player.player_arm_combined.play(player.player_arm_combined.WALK)


func physics_process(_delta: float) -> void:
	var dir: int = player.get_dir()

	player.velocity.x = float(dir) * player.player_movement_data.WALK_SPEED
	player.move_and_slide()

	if not dir:
		done.emit(player_state_machine.player_idle_state)
		return

	player.player_arm_combined.flip_h = player.velocity.x < 0.0
