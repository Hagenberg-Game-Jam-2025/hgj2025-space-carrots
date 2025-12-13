extends Node3D

@onready var _interaction_target : InteractionTarget = $InteractionTarget

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_interaction_target.on_interact.connect(_on_interact)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_interact(source : ControlEntity) -> void:
	rotate_y(PI * 0.5)
