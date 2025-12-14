class_name SfxPlayer
extends AudioStreamPlayer

func play_death_sound() -> void:
	stream = pick_death_sound()
	play()

func pick_death_sound() -> AudioStreamOggVorbis:
	return AudioStreamOggVorbis.load_from_file(_death_sound_pool.pick_random())

const _death_sound_pool : Array = [
	"res://resource/audio/death/death1.ogg",
	"res://resource/audio/death/death2.ogg",
	"res://resource/audio/death/death3.ogg",
	"res://resource/audio/death/death4.ogg",
]
