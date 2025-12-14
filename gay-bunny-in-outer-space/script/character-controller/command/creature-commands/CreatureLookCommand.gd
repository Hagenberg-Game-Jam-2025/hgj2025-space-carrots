extends CreatureCommand

class_name CreatureLookCommand

class Params:
	var twist_input : float
	var pitch_input : float
	
	func _init(_twist_input : float, _pitch_input : float) -> void:
		self.twist_input = _twist_input
		self.pitch_input = _pitch_input

func execute(control_entity : ControlEntity, data : Object = null) -> void:
	if data is Params and control_entity is Creature:
		control_entity.look(data.twist_input, data.pitch_input)
