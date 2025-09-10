class_name Player
extends CharacterBody2D
# Listens to input and update its position with collision resolution

@export var sound_effect_data: PlayerSoundEffectData
@export var movement_data: PlayerMovementData
@export var animation_name_data: PlayerAnimationNameData

@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var player_input: PlayerInput = $PlayerInput
@onready var player_animated_sprite: PlayerAnimatedSprite = $PlayerAnimatedSprite
@onready var player_save_component: PlayerSaveComponent = $PlayerSaveComponent


func _ready() -> void:
	add_to_group(GroupNameConstants.SAVABLE)
	player_save_component.start_owner_state_machine_request.connect(
		_on_player_save_component_start_owner_state_machine_request
	)
	player_save_component.read_world_state()


func _physics_process(delta: float) -> void:
	player_state_machine.physics_process(delta)


func reposition_to_door(given_global_position: Vector2) -> void:
	global_position = given_global_position


func _dump_state_to_world() -> void:
	player_save_component.dump_state_to_world()


func _on_player_save_component_start_owner_state_machine_request() -> void:
	player_state_machine.start()
