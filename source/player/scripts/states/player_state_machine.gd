class_name PlayerStateMachine
extends StateMachine

@onready var player_idle_state: PlayerState = $PlayerIdleState
@onready var player_walk_state: PlayerState = $PlayerWalkState


## Populate state machine with states, pass player to each state, then it enters first state
func setup_states(player_reference: Player) -> void:
	for child in get_children():
		if child is PlayerState:
			child.set_player(player_reference)
			add_state(child)

	start(player_idle_state)
