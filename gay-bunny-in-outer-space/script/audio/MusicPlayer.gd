class_name MusicPlayer
extends AudioStreamPlayer

func _process(delta: float) -> void:
	if not playing and autoplay:
		play()
