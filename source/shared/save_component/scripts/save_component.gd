@icon("res://source/shared/save_component/assets/save.svg")
class_name SaveComponent
extends Node
# Put kid to savables group

@warning_ignore("unused_signal")
signal properties_initialized_by_save_file


func _ready() -> void:
	owner.add_to_group(GroupNameConstants.SAVABLES)
	_kid_ready()


func _kid_ready() -> void:
	pass
