class_name InteractionMarkerFloatAnimationPlayer
extends ValidatedAnimationPlayerNode

@export var animation_name_data: InteractionMarkerFloatAnimationNameData


func _ready() -> void:
	_validate_gui(animation_name_data)
