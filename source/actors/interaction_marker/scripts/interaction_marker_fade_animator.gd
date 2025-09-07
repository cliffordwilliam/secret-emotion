class_name InteractionMarkerFadeAnimator
extends ValidatedAnimationPlayer
# Interaction marker fade animation name props validator


func _ready() -> void:
	_validate_gui(InteractionMarkerFadeAnimationNameData.ALL)
