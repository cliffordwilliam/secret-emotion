class_name UiSaveSlotItem
extends PanelContainer
# UI Component for save page slot items

signal save_button_pressed(slot_name: String)

# This is a key that must be unique among siblings
var slot_name: String = ""

@onready var slot_name_label: Label = $MarginContainer/VBoxContainer/SlotName
@onready var save_button: Button = $MarginContainer/VBoxContainer/SaveButton


# Godot does not have initializer, have to call this manually after creation
func initialize(given_slot_name: String) -> void:
	slot_name = given_slot_name
	slot_name_label.text = given_slot_name


func _ready() -> void:
	save_button.pressed.connect(_on_save_button_pressed)


func _on_save_button_pressed() -> void:
	save_button_pressed.emit(slot_name)
