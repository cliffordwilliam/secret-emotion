@icon("res://source/actors/chest/assets/archive.svg")
class_name Chest
extends Area2D

@onready var chest_state_machine: ChestStateMachine = $ChestStateMachine
@onready var chest_input: PlayerInput = $PlayerInput
@onready var chest_animated_sprite: ChestAnimatedSprite = $ChestAnimatedSprite
@onready var interaction_marker: InteractionMarker = $InteractionMarker
@onready var chest_save_component: ChestSaveComponent = $ChestSaveComponent


func _ready() -> void:
	chest_save_component.read_world_state()


func _physics_process(delta: float) -> void:
	chest_state_machine.physics_process(delta)


func _on_body_entered(_body: Node2D) -> void:
	chest_input.set_enable_input(true)
	interaction_marker.set_active()


func _on_body_exited(_body: Node2D) -> void:
	chest_input.set_enable_input(false)
	interaction_marker.set_inactive()


func _on_chest_save_component_data_loaded() -> void:
	chest_state_machine.start()
