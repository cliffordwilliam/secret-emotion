class_name PlayerRunStateBaseExitStrategy
extends RefCounted
# Base class for all player run state exit strategies
# This is an extension of the owner

var owner: PlayerRunState


func _init(given_owner: PlayerRunState) -> void:
	owner = given_owner


func can_handle() -> bool:
	return false


func get_next_state() -> PlayerState:
	return null
