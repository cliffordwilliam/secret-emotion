class_name PlayerState
extends State
# Stores owner belongings (so lsp knows owner 'Player' type)

var player: Player
var player_state_machine: PlayerStateMachine
var player_input: PlayerInput


func _ready() -> void:
	player = owner as Player
	await player.ready
	player_state_machine = player.player_state_machine
	player_input = player.player_input
