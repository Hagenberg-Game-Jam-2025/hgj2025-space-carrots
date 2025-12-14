extends ControlEntity

class_name MiniGameControlEntity

var mini_game : MiniGame

@onready
var mini_game_subviewport : SubViewport = $SubViewport

@onready
var mini_game_interaction_area : Area3D = $MiniGameQuadMesh/Area3D

@onready
var mini_game_quad_mesh : MiniGameScreenQuadMesh = $MiniGameQuadMesh

@export
var interaction_target : InteractionTarget

var player_entity : ControlEntity

func _ready() -> void:
	super._ready()
	possessed.connect(_on_possessed)
	
	interaction_target.on_interact.connect(_on_interact)

func load_mini_game(mini_game_scene : PackedScene) -> void:
	var mini_game_instance : Node = mini_game_scene.instantiate()
	
	if !(mini_game_instance is MiniGame):
		push_error("Packed Scene must be of type MiniGame")
		return
	
	#for (node : Node in mini_game_subviewport.get_children()):
		#node.
	
	mini_game_subviewport.add_child(mini_game_instance)
	
	
	

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
