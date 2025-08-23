class_name RiverAnimatedSprite
extends ValidatedAnimatedSprite

@export var animation_name_data: RiverAnimationNameData


func _ready() -> void:
	_validate_gui(animation_name_data)
	play(animation_name_data.FLOW)
