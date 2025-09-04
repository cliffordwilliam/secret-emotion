class_name PlayerRunStateWalkExitStrategy
extends PlayerRunStateBaseExitStrategy


func can_handle() -> bool:
	return owner.player_input.is_shift_held()


func get_next_state() -> PlayerState:
	return owner.player_state_machine.player_walk_state
