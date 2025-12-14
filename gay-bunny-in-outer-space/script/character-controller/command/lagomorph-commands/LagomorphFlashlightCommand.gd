extends LagomorphCommand

class_name LagoMorphFlashLightCommand

func execute(control_entity : ControlEntity, data : Object = null) -> void:
	if (control_entity is Lagomorph):
		control_entity.toggle_light()
