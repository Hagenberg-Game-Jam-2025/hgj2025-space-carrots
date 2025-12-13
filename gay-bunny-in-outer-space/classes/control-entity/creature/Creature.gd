extends ControlEntity

class_name Creature

@export_category("Movement")

@export_range(0, 10, 0.1, "or_greater")
var move_speed : float

@export_range(0, 10, 0.1, "or_greater")
var jump_speed : float

var is_moving : bool = false

func _ready() -> void:
	super._ready()
	
func _physics_process(delta: float) -> void:
	super._physics_process(delta)

	if not is_on_floor():
		velocity += get_gravity() * delta

	if !is_moving:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		velocity.z = move_toward(velocity.z, 0, move_speed)
	
	is_moving = false
	
func move(input : Vector2) -> void:
	var direction : Vector3 = (anchor.camera_anchor.transform.basis * Vector3(input.x, 0, input.y)).normalized()
	
	if direction:
		velocity.x = direction.x * move_speed
		velocity.z = direction.z * move_speed
	
	is_moving = true
	
func jump() -> void:
	if is_on_floor():
		velocity.y = jump_speed
	
func look(twist_input : float, pitch_input : float) -> void:
	anchor.look(twist_input, pitch_input)
