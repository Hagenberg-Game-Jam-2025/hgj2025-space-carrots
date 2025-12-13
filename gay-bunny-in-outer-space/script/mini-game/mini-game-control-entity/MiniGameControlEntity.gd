extends ControlEntity

class_name MiniGameControlEntity

@export
var mini_game : MiniGame

var player_entity : ControlEntity

func _ready() -> void:
	super._ready()
	possessed.connect(_on_possessed)
	
func _on_possessed(mind : Mind, last_possessed_control_entity : ControlEntity) -> void:
	player_entity = last_possessed_control_entity

func release_player() -> void:
	if player != null:
		player.possess(player_entity)
