class_name InteractionTarget

extends CollisionObject3D

signal on_interact(source : ControlEntity)

#@export var collision_shape: Shape3D
#
#func _ready() -> void:
	#var owner_id: int = create_shape_owner(CollisionShape3D.new())
	#shape_owner_add_shape(owner_id, collision_shape)

func receive_interaction(source : ControlEntity) -> void:
	on_interact.emit(source)
