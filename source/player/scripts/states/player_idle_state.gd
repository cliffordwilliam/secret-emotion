class_name PlayerIdleState
extends PlayerState


func enter() -> void:
	player.velocity.x = 0.0
	player.player_arm_combined.play(player.player_arm_combined.IDLE)


func physics_process(_delta: float) -> void:
	if player.get_dir():
		done.emit(player_state_machine.player_walk_state)
