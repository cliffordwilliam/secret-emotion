class_name ChestState
extends State
# Stores owner belongings (so lsp knows owner type)

var chest: Chest
var chest_state_machine: ChestStateMachine
var chest_input: PlayerInput
var chest_animated_sprite: ChestAnimatedSprite
var interaction_marker: InteractionMarker


func _ready() -> void:
	await owner.ready
	chest = owner as Chest
	chest_state_machine = chest.chest_state_machine
	chest_input = chest.chest_input
	chest_animated_sprite = chest.chest_animated_sprite
	interaction_marker = chest.interaction_marker
