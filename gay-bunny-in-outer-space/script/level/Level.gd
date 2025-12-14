extends Node3D

class_name Level

# The rovers should be children of the level ideally uwu

@export
var rovers : Array[Rover]

@export
var level_finish_text : String = ""

var repaired_rovers : int = 0

signal level_complete

# The level node should be in the origin point, makes stuff ieasier
# i just set it manually so queerin imeadly knows somthing is wrong
func _ready() -> void:
	position = Vector3.ZERO 
	
	for rover : Rover in rovers:
		rover.rover_repaired.connect(_on_rover_repaired)
	
func _on_rover_repaired() -> void:
	repaired_rovers += 1
	
	if (repaired_rovers == rovers.size()):
		level_complete.emit()
