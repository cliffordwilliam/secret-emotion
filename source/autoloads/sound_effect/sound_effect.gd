# This is an autoload class (SoundEffect)
extends Node
# Plays sound effect (footstep, explosion, BUT NOT MUSIC)
# Cache loaded AudioStream from sound file paths

const POOL_SIZE: int = 16
const BUS: StringName = "SFX"

var sound_cache: Dictionary[String, AudioStream] = {}


func _ready() -> void:
	for i: int in range(POOL_SIZE):
		var player: AudioStreamPlayer = AudioStreamPlayer.new()
		player.bus = BUS
		player.name = player.name + str(i)
		player.volume_db = 0.0
		add_child(player)


func play(sound_file_path: String) -> void:
	var audio_stream_player: AudioStreamPlayer = _get_available_player()
	if audio_stream_player:
		audio_stream_player.stream = _get_audio_stream(sound_file_path)
		audio_stream_player.play()


func _get_available_player() -> AudioStreamPlayer:
	for player: AudioStreamPlayer in get_children():
		if not player.playing:
			return player
	return null


func _get_audio_stream(sound_file_path: String) -> AudioStream:
	if sound_cache.has(sound_file_path):
		return sound_cache[sound_file_path]
	var stream: AudioStream = load(sound_file_path)
	sound_cache[sound_file_path] = stream
	return stream
