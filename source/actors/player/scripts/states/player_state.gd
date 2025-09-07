class_name PlayerState
extends State
# This is an extension of owner. It stores owner belongings

var player: Player
var player_state_machine: PlayerStateMachine
var player_input: PlayerInput
var player_animation_sprite: PlayerAnimatedSprite


func _ready() -> void:
	await owner.ready
	player = owner as Player
	player_state_machine = player.player_state_machine
	player_input = player.player_input
	player_animation_sprite = player.player_animated_sprite
