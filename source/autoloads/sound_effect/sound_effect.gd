# This is an autoload class (SoundEffect)
extends Node
# Plays sound effect (footstep, explosion, BUT NOT MUSIC)
# Cache loaded AudioStream from sound file paths

var audio_steam_instance_cache: Dictionary[String, AudioStream] = {}


func _ready() -> void:
	for i: int in range(SoundEffectConfigData.POOL_SIZE):
		var audio_stream_player_instance: AudioStreamPlayer = AudioStreamPlayer.new()
		audio_stream_player_instance.bus = SoundEffectConfigData.BUS
		audio_stream_player_instance.name = audio_stream_player_instance.name + str(i)
		audio_stream_player_instance.volume_db = 0.0
		add_child(audio_stream_player_instance)


func play(wav_file_path: String) -> void:
	if not ResourceLoader.exists(wav_file_path, "AudioStream"):
		return
	var audio_stream_player: AudioStreamPlayer = _get_not_busy_audio_stream_player()
	if audio_stream_player:
		audio_stream_player.stream = _get_audio_stream(wav_file_path)
		audio_stream_player.play()


func _get_not_busy_audio_stream_player() -> AudioStreamPlayer:
	for audio_stream_player: AudioStreamPlayer in get_children():
		if not audio_stream_player.playing:
			return audio_stream_player
	return null


func _get_audio_stream(wav_file_path: String) -> AudioStream:
	if audio_steam_instance_cache.has(wav_file_path):
		return audio_steam_instance_cache[wav_file_path]
	var audio_stream: AudioStream = load(wav_file_path)
	audio_steam_instance_cache[wav_file_path] = audio_stream
	return audio_stream
