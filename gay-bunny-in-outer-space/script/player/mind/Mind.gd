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
	if possessed_control_entity.player != null:
		return
	
	if current_controller != null:
		current_controller.queue_free()
	
	var controller_script : PackedScene

	if self is Player:
		controller_script = load(control_entity.controller_reference)

	var controller_instance : Controller = controller_script.instantiate()
	controller_instance.control_entity = control_entity
	add_child(controller_instance)
		
	current_controller = controller_instance

	self.possessed_control_entity.player = null
	self.possessed_control_entity = control_entity
	self.possessed_control_entity.player = self

	reparent.call_deferred(control_entity.anchor.camera_anchor)
		
	self.position = self.possessed_control_entity.anchor.camera_anchor.global_position
	self.rotation = self.possessed_control_entity.anchor.camera_anchor.global_rotation

	possessed.emit(control_entity)
