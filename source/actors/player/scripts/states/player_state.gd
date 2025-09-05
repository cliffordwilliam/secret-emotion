class_name PlayerState
extends State
# This is an extension of owner. It stores owner belongings

var player: Player
var player_state_machine: PlayerStateMachine
var player_input: PlayerInput
var player_animation_sprite: PlayerAnimatedSprite


func _ready() -> void:
	player = owner as Player
	await player.ready
	player_state_machine = player.player_state_machine
	player_input = player.player_input
	player_animation_sprite = player.player_animated_sprite
