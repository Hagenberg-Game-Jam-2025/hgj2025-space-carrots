extends Mind

class_name Player

func _ready() -> void:
	super._ready()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
