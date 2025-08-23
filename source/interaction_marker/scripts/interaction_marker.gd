@icon("res://source/interaction_marker/assets/message-circle-more.svg")
class_name InteractionMarker
extends Sprite2D

@onready var fade_animator: InteractionMarkerFadeAnimationPlayer = $FadeAnimator


func _ready() -> void:
	modulate.a = 0.0


func set_active() -> void:
	fade_animator.play(fade_animator.animation_name_data.FADE_IN)


func set_inactive() -> void:
	fade_animator.play(fade_animator.animation_name_data.FADE_OUT)
