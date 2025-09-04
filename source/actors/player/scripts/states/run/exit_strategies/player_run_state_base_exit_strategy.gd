class_name PlayerRunStateBaseExitStrategy
extends RefCounted

var owner: PlayerRunState


func _init(_owner: PlayerRunState) -> void:
	owner = _owner


func can_handle() -> bool:
	return false


func get_next_state() -> PlayerState:
	return null
