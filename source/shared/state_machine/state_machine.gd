class_name StateMachine
extends Node

var state_map: Dictionary[String, State] = {}
var current_state: State


func physics_process(delta: float) -> void:
	current_state.physics_process(delta)


func add_state(new_state: State) -> void:
	state_map[new_state.state_name] = new_state
	new_state.done.connect(_change_state)


func start(first_state_name: String) -> void:
	_change_state(first_state_name)


func _change_state(next_state_name: String) -> void:
	if current_state:
		current_state.exit()
	current_state = state_map.get(next_state_name)
	if not current_state:
		push_error("State '%s' not found in state_map." % next_state_name)
		return
	if current_state:
		current_state.enter()
