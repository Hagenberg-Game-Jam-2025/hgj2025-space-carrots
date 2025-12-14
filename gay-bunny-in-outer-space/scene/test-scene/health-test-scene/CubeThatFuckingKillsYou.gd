extends Node

@onready var interaction_target : InteractionTarget = $InteractionTarget

func _ready() -> void:
	interaction_target.on_interact.connect(_on_interacted)

func _on_interacted(source : ControlEntity) -> void:
	if source is Creature:
		(source as Creature).receive_damage(1)
