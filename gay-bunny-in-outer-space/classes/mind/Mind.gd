extends Node3D

class_name Mind

signal possessed(control_entity : ControlEntity)

@export_category("Control Entity")

@export
var possessed_control_entity : ControlEntity 


var current_controller : Controller

func _ready() -> void:
	if (possessed_control_entity != null):
		possess(possessed_control_entity)

func _physics_process(delta: float) -> void:
	self.global_position = possessed_control_entity.anchor.camera_anchor.global_position
	self.global_rotation = possessed_control_entity.anchor.camera_anchor.global_rotation

func possess(control_entity : ControlEntity) -> void:
	pass
