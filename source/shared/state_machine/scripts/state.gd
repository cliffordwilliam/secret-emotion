@icon("res://source/shared/state_machine/assets/refresh-ccw.svg")
class_name State
extends Node
# Base class with done signal for all kids to use
# Base state signature, since state machine expects all these methods to exists (enter, exit)
# So that kids only have to override the ones they need (override enter only)

@warning_ignore("unused_signal")
signal done(next_state: State)


func enter(_previous_state: State) -> void:
	pass


func exit() -> void:
	pass


func physics_process(_delta: float) -> void:
	pass
