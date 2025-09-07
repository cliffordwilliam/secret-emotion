class_name UiLoadSlotItem
extends PanelContainer
# UI Component for load page slot items

signal load_button_pressed(slot_name: String)
signal delete_button_pressed(slot_name: String)

# This is a key that must be unique among siblings
var slot_name: String = ""

@onready var slot_name_label: Label = $MarginContainer/VBoxContainer/SlotName
@onready var load_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/LoadButton
@onready var delete_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/DeleteButton


# Godot does not have initializer, have to call this manually after creation
func initialize(given_slot_name: String) -> void:
	slot_name = given_slot_name
	slot_name_label.text = given_slot_name


func _ready() -> void:
	load_button.pressed.connect(_on_load_button_pressed)
	delete_button.pressed.connect(_on_delete_button_pressed)


func _on_load_button_pressed() -> void:
	load_button_pressed.emit(slot_name)


func _on_delete_button_pressed() -> void:
	delete_button_pressed.emit(slot_name)
