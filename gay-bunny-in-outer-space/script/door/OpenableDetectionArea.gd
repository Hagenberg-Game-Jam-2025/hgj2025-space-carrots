extends Area3D

class_name OpenableDetectionArea

@export
var openable : Openable

func _ready() -> void:
	if openable == null:
		openable = get_parent_node_3d()
	
	collision_layer = 1
	collision_mask = 1
	
	self.body_entered.connect(openable.creature_entered)
	self.body_exited.connect(openable.creature_exited)
