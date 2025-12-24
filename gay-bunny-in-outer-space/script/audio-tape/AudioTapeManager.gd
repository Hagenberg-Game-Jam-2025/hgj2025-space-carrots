extends AudioStreamPlayer

class_name AudioTapeManager

var audio_tracks : Array[AudioTapeResource]

func _ready() -> void:
	add_to_group("AudioTapeManager")
	
	bus = "Audio Tapes"
	
	finished.connect(_on_finished)
	
func queue_audio_track(audio_tape_resource : AudioTapeResource) -> void:
	audio_tracks.append(audio_tape_resource)
	
	print(audio_tracks)
	
	if !playing:
		_play_track(audio_tracks[0])
	
func _on_finished() -> void:
	audio_tracks.remove_at(0)
	
	print("next audio track")
	
	if (audio_tracks.size() == 0):
		return
		
	_play_track(audio_tracks[0])

func _play_track(audio_tape : AudioTapeResource) -> void:
	stream = audio_tape.audio_track
	volume_db = audio_tape.db
	
	play()
	
