extends Node3D

class_name MiniGameScreen

@export
var mini_game_control_entity : MiniGameControlEntity

@export
var mini_game : MiniGame



func _process(delta: float) -> void:
	if (Input.is_key_label_pressed(KEY_0)):
		enter_screen()
		print("0 pressed")
		

func enter_screen() -> void:
	var player : Player = get_tree().get_first_node_in_group("Player")
	
	print(player)
	
	player.possess(mini_game_control_entity)
