# Autoload SoundEffect
extends Node

const POOL_SIZE: int = 16
const BUS: String = "SFX"

var sound_cache: Dictionary[String, AudioStream] = {}


func _ready() -> void:
	for i: int in range(POOL_SIZE):
		var player: AudioStreamPlayer = AudioStreamPlayer.new()
		player.bus = BUS
		add_child(player)


func play(sound_file_path: String) -> void:
	for player: AudioStreamPlayer in get_children():
		if not player.playing:
			player.stream = _get_audio_stream(sound_file_path)
			player.play()
			return


func _get_audio_stream(sound_file_path: String) -> AudioStream:
	if sound_cache.has(sound_file_path):
		return sound_cache[sound_file_path]
	var stream: AudioStream = load(sound_file_path)
	sound_cache[sound_file_path] = stream
	return stream
