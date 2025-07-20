class_name PlayerState
extends State

# State should have access to owner
var player: Player

# Shortcuts to avoid spamming `player.some_prop` everywhere
var player_state_machine: PlayerStateMachine


func set_player(value: Player) -> void:
	player = value
	player_state_machine = value.player_state_machine
