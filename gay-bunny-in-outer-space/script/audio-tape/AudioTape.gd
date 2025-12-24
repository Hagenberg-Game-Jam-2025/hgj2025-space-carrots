extends Node3D

class_name AudioTape

@export
var audio_track : AudioStream

# 16 db becuz thats the default i set it to so its loud enough 
@export
var audio_db : float = 16

func _on_interaction_target_on_interact(source: ControlEntity) -> void:
	var audio_tape_resource : AudioTapeResource = AudioTapeResource.new(audio_track, audio_db)
	
	var audio_tape_manager : AudioTapeManager = get_tree().get_first_node_in_group("AudioTapeManager") as AudioTapeManager
	
	print(audio_tape_manager)
	
	audio_tape_manager.queue_audio_track(audio_tape_resource)
