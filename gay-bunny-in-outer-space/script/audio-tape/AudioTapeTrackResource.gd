extends Resource

class_name AudioTapeResource

@export
var audio_track : AudioStream

@export
var db : float = 0

@export
var audio_name : String = ""

func _init(audio_track : AudioStream, db : float, audio_name: String) -> void:
	self.audio_track = audio_track
	self.db = db
	self.audio_name = audio_name
