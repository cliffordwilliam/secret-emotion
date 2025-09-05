@icon("res://source/actors/interaction_marker/assets/message-circle-more.svg")
class_name InteractionMarker
extends Sprite2D
# Render and plays interaction marker animation

@onready var fade_animator: InteractionMarkerFadeAnimationPlayer = $FadeAnimator
@onready var float_animator: InteractionMarkerFloatAnimationPlayer = $FloatAnimator


func _ready() -> void:
	modulate.a = 0.0


func set_active() -> void:
	fade_animator.play(InteractionMarkerFadeAnimationNameData.FADE_IN)
	float_animator.play(InteractionMarkerFloatAnimationNameData.FLOAT)


func set_inactive() -> void:
	fade_animator.play(InteractionMarkerFadeAnimationNameData.FADE_OUT)
	float_animator.pause()
