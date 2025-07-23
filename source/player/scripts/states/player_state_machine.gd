class_name PlayerStateMachine
extends StateMachine
# Stores states (idle, run, ...), for kid `change state` target

@onready var player_idle_state: PlayerState = $PlayerIdleState
@onready var player_walk_state: PlayerState = $PlayerWalkState
@onready var player_run_state: PlayerRunState = $PlayerRunState
