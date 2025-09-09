@icon("res://source/actors/chest/assets/archive.svg")
class_name Chest
extends Area2D
# Opens and close sprite animation on player input

@onready var chest_state_machine: ChestStateMachine = $ChestStateMachine
@onready var chest_input: PlayerInput = $PlayerInput
@onready var chest_animated_sprite: ChestAnimatedSprite = $ChestAnimatedSprite
@onready var interaction_marker: InteractionMarker = $InteractionMarker
@onready var chest_save_component: ChestSaveComponent = $ChestSaveComponent


func _ready() -> void:
	chest_state_machine.set_initial_state($ChestStateMachine/ChestCloseState)
	chest_input.disable_input()
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	chest_save_component.properties_initialized_by_save_file.connect(
		_on_chest_save_component_finished
	)
	chest_save_component.read_world_state()


func _physics_process(delta: float) -> void:
	chest_state_machine.physics_process(delta)


func _on_body_entered(_body: Node2D) -> void:
	chest_input.enable_input()
	interaction_marker.set_active()


func _on_body_exited(_body: Node2D) -> void:
	chest_input.disable_input()
	interaction_marker.set_inactive()


func _dump_state_to_world(slot_name: String = "") -> void:
	chest_save_component.dump_state_to_world(slot_name)


func _on_chest_save_component_finished() -> void:
	chest_state_machine.start()
