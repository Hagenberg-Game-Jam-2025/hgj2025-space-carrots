extends MiniGameCommand

class_name MiniGAmeExitCommand

func execute(control_entity : ControlEntity, data : Object = null) -> void:
	if control_entity is MiniGameControlEntity:
		control_entity.exit_screen()
