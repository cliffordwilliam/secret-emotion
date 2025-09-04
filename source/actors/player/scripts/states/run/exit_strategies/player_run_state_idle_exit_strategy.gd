class_name PlayerRunStateIdleExitStrategy
extends PlayerRunStateBaseExitStrategy


func can_handle() -> bool:
	return not owner.player_input.get_input_direction_x()


func get_next_state() -> PlayerState:
	return owner.player_state_machine.player_idle_state
