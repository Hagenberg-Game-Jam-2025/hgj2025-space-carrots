extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_hovered():
		modulate = Color(5.51, 5.51, 5.51, 0.608)
	else:
		modulate = Color(1.0, 1.0, 1.0, 0.0)
	pass
