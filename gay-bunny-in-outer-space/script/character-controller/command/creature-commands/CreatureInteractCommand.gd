# author: Martin

class_name CreatureInteractCommand
extends CreatureCommand


func execute(control_entity : ControlEntity, data : Object = null) -> void:
	if control_entity is Creature:
		(control_entity as Creature).try_interact(false)
