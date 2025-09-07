# This is an autoload class (SoundEffectFilePathContants)
extends Node
# Validates external engine values against codebase const (.wav file path)
# Why not ref counted? Because this needs _ready() to validate

const PLAYER_BASE_PATH_SFX_PATH: StringName = "res://source/actors/player/assets/"
const PLAYER_GRASS_FOOTSTEP_SFX_PATH: StringName = PLAYER_BASE_PATH_SFX_PATH + "grass_footstep.wav"
const PLAYER_JUMP_SFX_PATH: StringName = PLAYER_BASE_PATH_SFX_PATH + "jump.wav"
const PLAYER_SOFT_LAND_SFX_PATH: StringName = PLAYER_BASE_PATH_SFX_PATH + "soft_land.wav"
const ALL_SFX_PATHS: Array[StringName] = [
	PLAYER_GRASS_FOOTSTEP_SFX_PATH,
	PLAYER_JUMP_SFX_PATH,
	PLAYER_SOFT_LAND_SFX_PATH,
]


func _ready() -> void:
	_validate_files()


func _validate_files() -> void:
	for path: StringName in ALL_SFX_PATHS:
		if not FileAccess.file_exists(path):
			push_error("❌ Missing SFX file: %s" % path)
			get_tree().quit(1)

	print("✅ All SFX files exist.")
