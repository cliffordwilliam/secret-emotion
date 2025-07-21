class_name PlayerIdleState
extends PlayerState
# Player standing still


func enter() -> void:
	player.play_animation.emit(player.animation_name_data.IDLE)
	player.velocity.x = 0.0


func physics_process(_delta: float) -> void:
	if player.get_input_direction_x():
		done.emit(player_state_machine.player_walk_state)
