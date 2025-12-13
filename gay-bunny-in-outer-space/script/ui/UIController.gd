class_name UIController
extends Node

@onready var _interaction_hint : Label = $InteractionHint

func _ready() -> void:
	_interaction_hint.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_interaction_hint(show : bool) -> void:
	_interaction_hint.visible = show
