class_name PlayerState
extends State
# Stores owner (player) references (belongings)

var player: Player
var player_state_machine: PlayerStateMachine


func _ready() -> void:
	await owner.ready
	player = owner as Player
	player_state_machine = player.player_state_machine
