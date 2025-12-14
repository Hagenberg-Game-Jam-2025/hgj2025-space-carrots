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

@export_range(0, 0.3, 0.01, "or_greater")
var slow_down_when_jumping : float = 0.1

@export_category("Interaction")

@export
var can_interact : bool = true

@export_range(0, 10, 0.1, "or_greater")
var interaction_distance : float = 2

@export_flags_3d_physics
var interaction_layer : int

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
	
func move(input : Vector2) -> void:
	var direction : Vector3 = (anchor.twist_pivot.global_transform.basis * Vector3(input.x, 0, input.y)).normalized()
	
	velocity.x = direction.x * move_speed
	velocity.z = direction.z * move_speed
	
	is_moving = true
	
func start_running() -> void:
	is_running = true
	
func stop_running() -> void:
	is_running = false

func jump() -> void:
	if is_on_floor():
		velocity.y = jump_speed
	
func look(twist_input : float, pitch_input : float) -> void:
	anchor.look(twist_input, pitch_input)

## Casts a ray with the anchored camera as the origin and pivot, returns `true` if an
## [InteractionTarget] is found within range, and passes interaction to it if the [simulate] flag
## isn't set.
# author: Martin
func try_interact(simulate : bool) -> bool:
	if not can_interact:
		return false
	
	var space_state : PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	var from : Vector3 = anchor.camera_anchor.global_position
	var to : Vector3 = anchor.camera_anchor.global_position + Vector3(0, 0, -interaction_distance) * anchor.camera_anchor.global_basis.inverse()
	var query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(from, to, interaction_layer)
	query.collide_with_areas = true
	query.collide_with_bodies = false
	var result: Dictionary = space_state.intersect_ray(query)
	if result != null and result.has("collider"):
		var target: Object = result.collider
		if target != null and target is InteractionTarget:
			if not simulate:
				(target as InteractionTarget).receive_interaction(self)
			return true
			
	return false
