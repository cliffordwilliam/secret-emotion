class_name PlayerState
extends State
# Stores owner belongings (so lsp knows owner 'Player' type)

var player: Player
var player_state_machine: PlayerStateMachine
var player_input: PlayerInput
var player_animation_name_data: PlayerAnimationNameData
var player_movement_data: PlayerMovementData
var player_animation_sprite: PlayerAnimatedSprite
var player_sound_effect_data: PlayerSoundEffectData


func _ready() -> void:
	player = owner as Player
	await player.ready
	player_state_machine = player.player_state_machine
	player_input = player.player_input
	player_animation_name_data = player.animation_name_data
	player_movement_data = player.movement_data
	player_animation_sprite = player.player_animated_sprite
	player_sound_effect_data = player.sound_effect_data
