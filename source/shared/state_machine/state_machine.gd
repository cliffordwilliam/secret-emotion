class_name StateMachine
extends Node

# Common state machine props
var state_data: StateData

var current_state: State


## subscribe to kids done event, and enter first state
func init() -> void:
	for child in find_children("*", "State"):
		child.done.connect(_change_state)
	await owner.ready
	_change_state(get_node(state_data.initial_state_path))


func physics_process(delta: float) -> void:
	current_state.physics_process(delta)


func _change_state(next_state: State) -> void:
	if current_state:
		current_state.exit()
	current_state = get_node(next_state.get_path())
	if current_state:
		current_state.enter()
