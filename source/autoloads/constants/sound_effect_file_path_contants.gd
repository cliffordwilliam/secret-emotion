# This is an autoload class (SoundEffectFilePathContants)
extends ValidatedFilePath
# Validates external engine values against codebase const (.wav file path)
# Why not ref counted? Because this needs _ready() to validate

# The other const autoload scene file paths needs String since its to be preloaded
const PLAYER_BASE_SFX_PATH: String = "res://source/actors/player/assets/"
const PLAYER_GRASS_FOOTSTEP_SFX_PATH: String = PLAYER_BASE_SFX_PATH + "grass_footstep.wav"
const PLAYER_JUMP_SFX_PATH: String = PLAYER_BASE_SFX_PATH + "jump.wav"
const PLAYER_SOFT_LAND_SFX_PATH: String = PLAYER_BASE_SFX_PATH + "soft_land.wav"

const ALL_SFX_PATHS: Array[String] = [
	PLAYER_GRASS_FOOTSTEP_SFX_PATH,
	PLAYER_JUMP_SFX_PATH,
	PLAYER_SOFT_LAND_SFX_PATH,
]


func _ready() -> void:
	_validate_file_path(ALL_SFX_PATHS)
