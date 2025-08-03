class_name InteractionMarkerFadeAnimationPlayer
extends ValidatedAnimationPlayerNode

@export var animation_name_data: InteractionMarkerFadeAnimationNameData


func _ready() -> void:
	_validate_gui(animation_name_data)


func _on_set_active_request() -> void:
	play(animation_name_data.FADE_IN)


func _on_set_inactive_request() -> void:
	play(animation_name_data.FADE_OUT)
