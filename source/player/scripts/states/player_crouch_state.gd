class_name PlayerCrouchState
extends PlayerState
# Player crouching still


func enter(_previous_state: State) -> void:
	player.play_animation.emit(player.animation_name_data.TO_CROUCH)
	player.velocity.x = 0.0


func physics_process(_delta: float) -> void:
	if not player_input.is_down_held():
		done.emit(player_state_machine.player_idle_state)
