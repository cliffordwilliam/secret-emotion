class_name PlayerRunStateCrouchExitStrategy
extends PlayerRunStateBaseExitStrategy
# Handle exit to crouch condition


func can_handle() -> bool:
	return owner.player_input.is_down_held()


func get_next_state() -> PlayerState:
	return owner.player_state_machine.player_crouch_state
