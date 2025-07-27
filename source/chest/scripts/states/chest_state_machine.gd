class_name ChestStateMachine
extends StateMachine
# Stores states (idle, run, ...), for kid `change state` target

@onready var chest_close_state: ChestCloseState = $ChestCloseState
@onready var chest_open_state: ChestOpenState = $ChestOpenState
