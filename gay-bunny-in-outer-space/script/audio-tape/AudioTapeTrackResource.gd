extends Resource

class_name AudioTapeResource

@export
var audio_track : AudioStream

@export
var db : float = 0

func _init(audio_track : AudioStream, db : float) -> void:
	self.audio_track = audio_track
	self.db = db
