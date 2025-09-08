# This is an autoload class (SoundEffect)
extends Node
# Plays sound effect (footstep, explosion, BUT NOT MUSIC)
# Cache loaded AudioStream from sound file paths

var loaded_sfx_cache: Dictionary[String, AudioStream] = {}


func _ready() -> void:
	for i: int in range(SoundEffectConfigData.POOL_SIZE):
		var sfx_player: AudioStreamPlayer = AudioStreamPlayer.new()
		sfx_player.bus = SoundEffectConfigData.BUS
		add_child(sfx_player)


func play(wav_file_path: String) -> void:
	var sfx_player: AudioStreamPlayer = _get_not_busy_sfx_player()
	if sfx_player:
		sfx_player.stream = _get_loaded_sfx(wav_file_path)
		sfx_player.play()


func _get_not_busy_sfx_player() -> AudioStreamPlayer:
	for sfx_player: AudioStreamPlayer in get_children():
		if not sfx_player.playing:
			return sfx_player
	return null


func _get_loaded_sfx(wav_file_path: String) -> AudioStream:
	if loaded_sfx_cache.has(wav_file_path):
		return loaded_sfx_cache[wav_file_path]
	var loaded_sfx: AudioStream = load(wav_file_path)
	loaded_sfx_cache[wav_file_path] = loaded_sfx
	return loaded_sfx
