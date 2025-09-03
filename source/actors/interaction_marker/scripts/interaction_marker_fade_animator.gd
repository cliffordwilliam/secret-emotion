class_name InteractionMarkerFadeAnimationPlayer
extends ValidatedAnimationPlayerNode
# Interaction marker fade animation name props validator

@export var animation_name_data: InteractionMarkerFadeAnimationNameData


func _ready() -> void:
	_validate_gui(animation_name_data)
