@icon("res://source/shared/state_machine/assets/refresh-ccw.svg")
class_name State
extends Node
# Base state signature

@warning_ignore("unused_signal")
signal done(next_state: State)


func enter() -> void:
	pass


func exit() -> void:
	pass


func physics_process(_delta: float) -> void:
	pass
