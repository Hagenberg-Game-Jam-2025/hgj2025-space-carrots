# author: Martin
class_name CreatureReceiveDamageCommand
extends CreatureCommand

class Params:
	var damage : int
	
	func _init(_damage : int) -> void:
		self.damage = _damage

func execute(control_entity : ControlEntity, data : Object = null) -> void:
	if data is Params and control_entity is Creature:
		(control_entity as Creature).receive_damage((data as Params).damage)
