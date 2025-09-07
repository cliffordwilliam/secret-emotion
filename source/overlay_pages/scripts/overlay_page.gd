class_name OverlayPage
extends Control
# Base class with done signal for all kids to use
# Base overlay page signature, since overlay page expects all these methods to exists (enter, exit)
# So that kids only have to override the ones they need (override enter only)


func enter() -> void:
	pass


func exit() -> void:
	pass
