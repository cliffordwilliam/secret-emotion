class_name SavePoint
extends Area2D
# Allow access to save menu

@export var animation_name_data: SavePointAnimationNameData

@onready var save_point_input: PlayerInput = $PlayerInput
@onready var save_point_animated_sprite: SavePointAnimatedSprite = $SavePointAnimatedSprite
@onready var interaction_marker: InteractionMarker = $InteractionMarker


func _ready() -> void:
	save_point_animated_sprite.play(animation_name_data.SPIN)
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _physics_process(_delta):
	if save_point_input.is_up_tapped():
		pass


func _on_body_entered(_body: Node2D) -> void:
	save_point_input.set_enable_input(true)
	interaction_marker.set_active()


func _on_body_exited(_body: Node2D) -> void:
	save_point_input.set_enable_input(false)
	interaction_marker.set_inactive()
