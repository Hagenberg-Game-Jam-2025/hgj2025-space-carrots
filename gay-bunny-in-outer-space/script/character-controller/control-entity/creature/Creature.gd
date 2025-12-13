extends ControlEntity

class_name Creature

@export_category("Movement")

var move_speed : float : 
	get():
		if is_running:
			return base_move_speed * run_multiplier
		else:
			return base_move_speed

@export_range(0, 10, 0.1, "or_greater")
var base_move_speed : float = 1

@export_range(0, 10, 0.1, "or_greater")
var jump_speed : float = 5

@export_range(1, 5, 0.1, "or_greater")
var run_multiplier : float

var is_moving : bool = false
var is_running : bool = false

func _ready() -> void:
	super._ready()
	
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
		
	if not is_on_floor():
		velocity += get_gravity() * delta

	if !is_moving:
		velocity.x = move_toward(velocity.x, 0, base_move_speed)
		velocity.z = move_toward(velocity.z, 0, base_move_speed)
	
	move_and_slide()
	
	is_moving = false
	is_running = false
	
func move(input : Vector2) -> void:
	var direction : Vector3 = (anchor.twist_pivot.global_transform.basis * Vector3(input.x, 0, input.y)).normalized()
		
	velocity.x = direction.x * move_speed
	velocity.z = direction.z * move_speed
	
	is_moving = true
	
func run() -> void:
	is_running = true
	
func jump() -> void:
	if is_on_floor():
		velocity.y = jump_speed
	
func look(twist_input : float, pitch_input : float) -> void:
	anchor.look(twist_input, pitch_input)
