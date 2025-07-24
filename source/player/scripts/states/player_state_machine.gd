class_name PlayerStateMachine
extends StateMachine
# Stores states (idle, run, ...), for kid `change state` target

@onready var player_idle_state: PlayerIdleState = $PlayerIdleState
@onready var player_walk_state: PlayerWalkState = $PlayerWalkState
@onready var player_run_state: PlayerRunState = $PlayerRunState
@onready var player_crouch_state: PlayerCrouchState = $PlayerCrouchState
