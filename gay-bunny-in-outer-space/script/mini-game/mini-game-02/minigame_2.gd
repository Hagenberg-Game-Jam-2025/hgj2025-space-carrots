extends MiniGame

@export var max_hit_counter:int = 10

var is_inside:bool = false
var time:float = 0.75
var hit_counter:int = 0
var time_passed: float = 0.0

func _ready() -> void:
	$Area2D.position = Vector2(randi() % 1920, randi() % 1080)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_passed += delta
	
	if time_passed > time:
		$Area2D.position = Vector2(randi() % 1920, randi() % 1080)
		time_passed = 0.0


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and is_inside and event.is_released():
		# move charakter right
		hit_counter += 1
		
		if hit_counter >= max_hit_counter:
			mini_game_finished.emit()

func _on_area_2d_mouse_entered() -> void:
	is_inside = true

func _on_area_2d_mouse_exited() -> void:
	is_inside = false
