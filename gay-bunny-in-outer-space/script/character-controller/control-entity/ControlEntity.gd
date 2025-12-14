extends CharacterBody3D

class_name ControlEntity

signal possessed(mind : Mind, last_control_entity : ControlEntity)

@export_category("Anchor")

@export
var anchor : Anchor

@export_category("Controller")

@export
var controller_reference : StringName

var player : Player

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	pass
