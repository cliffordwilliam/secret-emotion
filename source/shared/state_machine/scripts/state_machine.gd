@icon("res://source/shared/state_machine/assets/shuffle.svg")
class_name StateMachine
extends Node
# Listens to kid 'done' event to change current state

var current_state: State


func _ready() -> void:
	for child in get_children():
		child.done.connect(_change_state)
	await owner.ready
	_change_state(get_child(0))


func physics_process(delta: float) -> void:
	current_state.physics_process(delta)


func _change_state(next_state: State) -> void:
	if current_state:
		current_state.exit()
	current_state = get_node(next_state.get_path())
	if current_state:
		current_state.enter()
