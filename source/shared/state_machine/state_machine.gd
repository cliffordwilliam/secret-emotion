class_name StateMachine
extends Node

var state_map: Dictionary[String, State] = {}
var current_state: State


func physics_process(delta: float) -> void:
	current_state.physics_process(delta)


func add_state(new_state: State) -> void:
	state_map[new_state.name] = new_state
	new_state.done.connect(_change_state)


func start(next_state: State) -> void:
	_change_state(next_state)


func _change_state(next_state: State) -> void:
	if current_state:
		current_state.exit()
	current_state = state_map[next_state.name]
	if current_state:
		current_state.enter()
