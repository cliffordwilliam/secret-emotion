class_name SaveMenu
extends CenterContainer
# TODO: Delete this, we want 2 seperated page, save and load
# TODO: But is that redundant? Yeah but at least its flexible and UI is messy in nature anyways

@warning_ignore("unused_signal")
signal player_pressed_save_button

enum ActionType { SAVE, LOAD }
@export var action: ActionType = ActionType.LOAD

var strategy: SaveMenuBaseModeStrategy
var strategy_manager: SaveMenuModeStrategyManager = SaveMenuModeStrategyManager.new()

@onready var label: Label = $VBoxContainer/Label
@onready var button: Button = $VBoxContainer/Button
@onready var button_2: Button = $VBoxContainer/Button2
@onready var button_3: Button = $VBoxContainer/Button3


func _ready() -> void:
	strategy = strategy_manager.get_strategy(self)

	strategy.on_ready_logic()

	button.pressed.connect(func() -> void: handle_button(WorldState.SaveSlot.SLOT_0))
	button_2.pressed.connect(func() -> void: handle_button(WorldState.SaveSlot.SLOT_1))
	button_3.pressed.connect(func() -> void: handle_button(WorldState.SaveSlot.SLOT_2))


func handle_button(slot: WorldState.SaveSlot) -> void:
	strategy.on_button_pressed_logic(slot)
