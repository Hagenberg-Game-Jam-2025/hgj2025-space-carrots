extends CreatureController

class_name LagomorphController

var lagomorphFlashlightCommand : LagoMorphFlashLightCommand = LagoMorphFlashLightCommand.new()

func _process(delta: float) -> void:
	super._process(delta)
	
	if Input.is_action_just_pressed("lagomorph_flash_light_command"):
		lagomorphFlashlightCommand.execute(control_entity)
