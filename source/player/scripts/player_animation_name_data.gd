class_name PlayerAnimationNameData
extends Resource
# Player animation name props + next animation bindings (to_run -> run)

const IDLE: StringName = "idle"
const WALK: StringName = "walk"
const TO_RUN: StringName = "to_run"
const RUN: StringName = "run"
const RUN_TO_IDLE: StringName = "run_to_idle"
const TO_CROUCH: StringName = "to_crouch"
const CROUCH: StringName = "crouch"
const CROUCH_TO_IDLE: StringName = "crouch_to_idle"
const TURN_TO_RUN: StringName = "turn_to_run"
const JUMP: StringName = "jump"
const TO_FALL: StringName = "to_fall"
const FALL: StringName = "fall"
const FALL_TO_IDLE: StringName = "fall_to_idle"
const ALL: Array[StringName] = [
	IDLE,
	WALK,
	TO_RUN,
	RUN,
	RUN_TO_IDLE,
	TO_CROUCH,
	CROUCH,
	CROUCH_TO_IDLE,
	TURN_TO_RUN,
	JUMP,
	TO_FALL,
	FALL,
	FALL_TO_IDLE,
]

const FOLLOWUPS: Dictionary[StringName, StringName] = {
	TO_RUN: RUN,
	RUN_TO_IDLE: IDLE,
	TO_CROUCH: CROUCH,
	CROUCH_TO_IDLE: IDLE,
	TURN_TO_RUN: RUN,
	TO_FALL: FALL,
	FALL_TO_IDLE: IDLE,
}
