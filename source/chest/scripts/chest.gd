@icon("res://source/chest/assets/archive.svg")
class_name Chest
extends Area2D

@export var animation_name_data: ChestAnimationNameData

@onready var chest_state_machine: ChestStateMachine = $ChestStateMachine
@onready var chest_input: PlayerInput = $PlayerInput
@onready var chest_animated_sprite: ChestAnimatedSprite = $ChestAnimatedSprite
@onready var interaction_marker: InteractionMarker = $InteractionMarker
@onready var player_input: PlayerInput = $PlayerInput
@onready var chest_save_component: ChestSaveComponent = $ChestSaveComponent


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	chest_save_component.start_owner_state_machine_request.connect(
		_on_chest_save_component_start_owner_state_machine_request
	)
	chest_save_component.read_world_state()


func _physics_process(delta):
	chest_state_machine.physics_process(delta)


func _on_body_entered(_body: Node2D) -> void:
	player_input.set_enable_input(true)
	interaction_marker.set_active()


func _on_body_exited(_body: Node2D) -> void:
	player_input.set_enable_input(false)
	interaction_marker.set_inactive()


func _on_room_player_entered_door() -> void:
	chest_save_component.dump_state_to_world()


func _on_chest_save_component_start_owner_state_machine_request() -> void:
	chest_state_machine.start()
