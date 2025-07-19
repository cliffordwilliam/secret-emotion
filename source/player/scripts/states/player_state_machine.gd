class_name PlayerStateMachine
extends StateMachine

@onready var first_state: PlayerState = $PlayerIdleState
@onready var player_idle_state: PlayerState = $PlayerIdleState
@onready var player_walk_state: PlayerState = $PlayerWalkState


func setup_states(player_reference: Player) -> void:
	for child in get_children():
		if child is PlayerState:
			child.player = player_reference
			child.player_state_machine = self
			add_state(child)

	start(first_state.state_name)
