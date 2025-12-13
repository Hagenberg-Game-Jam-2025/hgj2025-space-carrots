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

@export
var interaction_target : InteractionTarget

var player_entity : ControlEntity

func _ready() -> void:
	super._ready()
	possessed.connect(_on_possessed)
	
	interaction_target.on_interact.connect(_on_interact)

func _on_possessed(mind : Mind, last_possessed_control_entity : ControlEntity) -> void:
	player_entity = last_possessed_control_entity

func _on_interact(control_entity : ControlEntity) -> void:
	enter_screen()

func release_player() -> void:
	if player != null:
		player.possess(player_entity)

func enter_screen() -> void:
	var player : Player = get_tree().get_first_node_in_group("Player")	
	player.possess(self)

func exit_screen() -> void:
	var player : Player = get_tree().get_first_node_in_group("Player")
		
	player.possess(player_entity)
