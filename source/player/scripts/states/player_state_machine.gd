class_name PlayerStateMachine
extends StateMachine

# Disk -> props
@onready var player_state_data: PlayerStateData = (
	preload("res://source/player/resources/player_state_data.tres").duplicate().init()
)

# Stores states (idle, run, ...), for kid `change state` target
@onready var player_idle_state: PlayerState = $PlayerIdleState
@onready var player_walk_state: PlayerState = $PlayerWalkState


# Pass props to parent, then enter first state
func _ready():
	state_data = player_state_data
	super.init()
