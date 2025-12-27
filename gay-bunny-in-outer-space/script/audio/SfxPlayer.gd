class_name SfxPlayer
extends AudioStreamPlayer

@export
var _death_sound_pool : Array[AudioStream] = []

func play_death_sound() -> void:
	stream = _death_sound_pool.pick_random()
	play()
