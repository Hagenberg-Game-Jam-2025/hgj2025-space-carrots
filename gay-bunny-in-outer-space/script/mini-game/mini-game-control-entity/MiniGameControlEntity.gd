extends ControlEntity

class_name MiniGameControlEntity

@export
var mini_game : MiniGame

@export
var mini_game_subviewport : SubViewport

@export
var mini_game_interaction_area : Area3D

@export
var mini_game_quad_mesh : MiniGameScreenQuadMesh

var player_entity : ControlEntity

func _ready() -> void:
	super._ready()
	possessed.connect(_on_possessed)
	
func _on_possessed(mind : Mind, last_possessed_control_entity : ControlEntity) -> void:
	player_entity = last_possessed_control_entity

func release_player() -> void:
	if player != null:
		player.possess(player_entity)

func _process(delta: float) -> void:
	if (Input.is_key_label_pressed(KEY_0)):
		enter_screen()
		print("0 pressed")
	
	
	if (Input.is_key_label_pressed(KEY_1)):
		exit_screen()
		print("0 pressed")

func enter_screen() -> void:
	var player : Player = get_tree().get_first_node_in_group("Player")
	
	print(player)
	
	player.possess(self)

func exit_screen() -> void:
	var player : Player = get_tree().get_first_node_in_group("Player")
	
	print(player)
	
	player.possess(player_entity)
