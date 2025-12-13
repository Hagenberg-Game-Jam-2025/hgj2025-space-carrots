extends Controller

class_name CreatureController

var creature_movement_command : CreatureMovementCommand = CreatureMovementCommand.new()
var creature_jump_command : CreatureJumpCommand = CreatureJumpCommand.new()
var creature_look_command : CreatureLookCommand = CreatureLookCommand.new()
var creature_start_running_command : CreatureStartRunningCommand = CreatureStartRunningCommand.new()
var creature_stop_running_command : CreatureStopRunningCommand = CreatureStopRunningCommand.new()


@export_category("Control Settings")
@export
var mouse_sensitivity : float = 0.01

var twist_input : float = 0.0
var pitch_input : float = 0.0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	if control_entity is Creature:
		var input_dir : Vector2 = Input.get_vector("creature_move_left", "creature_move_right", "creature_move_forwards", "creature_move_backwards")

		creature_movement_command.execute(control_entity, CreatureMovementCommand.Params.new(input_dir))

		creature_look_command.execute(control_entity, CreatureLookCommand.Params.new(twist_input, pitch_input))

		if (Input.is_action_just_pressed("creature_jump")):
			creature_jump_command.execute(control_entity)
			
		if (Input.is_action_just_pressed("creature_run")):
			creature_start_running_command.execute(control_entity)
		
		if (Input.is_action_just_released("creature_run")):
			creature_stop_running_command.execute(control_entity)
			

	pitch_input = 0
	twist_input = 0

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
