@icon("res://source/interaction_marker/assets/message-circle-more.svg")
extends Sprite2D

signal set_active_request
signal set_inactive_request


func _ready() -> void:
	modulate.a = 0.0


func set_active() -> void:
	set_active_request.emit()


func set_inactive() -> void:
	set_inactive_request.emit()
