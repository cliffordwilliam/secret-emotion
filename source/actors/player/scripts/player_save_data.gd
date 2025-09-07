class_name PlayerSaveData
extends Resource
# Player props (key and value) to be saved to disk

# TODO: Remove this, just use dto
const KEY_CURRENT_STATE_NAME: StringName = "current_state_name"
const KEY_POSITION_X: StringName = "position_x"
const KEY_POSITION_Y: StringName = "position_y"
const KEY_FLIP_H: StringName = "flip_h"

var current_state_name: StringName
var position_x: float
var position_y: float
var flip_h: bool
