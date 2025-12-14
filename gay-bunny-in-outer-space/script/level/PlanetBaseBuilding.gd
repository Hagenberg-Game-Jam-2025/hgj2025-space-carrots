extends Node3D

class_name PlanetBaseBuilding


var is_unlocked : bool = false

signal enter_building

@onready
var interaction_target : InteractionTarget = $InteractionTarget

@onready
var fix_rover_prompt : Label3D = $FixRoverPrompt

func _ready() -> void:
	interaction_target.on_interact.connect(_on_door_interact)
	
func _on_door_interact(source : ControlEntity) -> void:
	if (is_unlocked):
		enter_building.emit()
	else:
		fix_rover_prompt.show()
		
		await get_tree().create_timer(5).timeout
		
		fix_rover_prompt.hide()
		
