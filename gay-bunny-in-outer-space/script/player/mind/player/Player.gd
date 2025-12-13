extends Mind

class_name Player

@export
var ui_controller : UIController

func _ready() -> void:
	super._ready()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	if ui_controller != null and possessed_control_entity is Creature:
		ui_controller.show_interaction_hint((possessed_control_entity as Creature).try_interact(true))
