class_name ChestSaveData
extends RefCounted
# Chest props (key and value) to be saved to disk

# TODO: Delete this, no need schema for save, use db dto instead
const KEY_CURRENT_STATE_NAME: StringName = "current_state_name"

var current_state_name: StringName
