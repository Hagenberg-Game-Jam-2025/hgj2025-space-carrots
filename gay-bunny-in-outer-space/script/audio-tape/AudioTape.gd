extends Node3D

class_name AudioTape

@export
var audio_track : AudioStream

func _ready() -> void:
	$AudioStreamPlayer3D.stream = audio_track

func _on_interaction_target_on_interact(source: ControlEntity) -> void:
	if !$AudioStreamPlayer3D.playing:
		$AudioStreamPlayer3D.play()
