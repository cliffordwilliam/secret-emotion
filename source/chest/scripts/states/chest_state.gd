class_name ChestState
extends State
# Stores owner belongings (so lsp knows owner 'Player' type)

var chest: Chest
var chest_state_machine: ChestStateMachine
var chest_input: PlayerInput
var chest_animation_name_data: ChestAnimationNameData


func _ready() -> void:
	chest = owner as Chest
	await chest.ready
	chest_state_machine = chest.chest_state_machine
	chest_input = chest.chest_input
	chest_animation_name_data = chest.animation_name_data
