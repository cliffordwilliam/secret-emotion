class_name PlayerRunStateJumpExitStrategy
extends PlayerRunStateBaseExitStrategy


func can_handle() -> bool:
	return owner.player_input.is_jump_tapped()


func get_next_state() -> PlayerState:
	return owner.player_state_machine.player_jump_state
