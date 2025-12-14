extends Creature

class_name Lagomorph

@export
var flash_light : SpotLight3D

func toggle_light() -> void:
	if flash_light.visible:
		flash_light.hide()
	else:
		flash_light.show()

func _ready() -> void:
	super._ready()
	
	$Timer.timeout.connect(_on_timeout)
	

func _on_timeout() -> void:
	print("timer")
	receive_damage(1)
