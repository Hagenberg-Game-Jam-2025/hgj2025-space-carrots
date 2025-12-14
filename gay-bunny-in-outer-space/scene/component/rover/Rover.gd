# author: zozo
class_name Rover

extends Node3D

signal rover_repaired()

@export
var mini_games : Array[PackedScene]

@export
var rover_name : String = ""

var current_mini_game : int = 0

@onready
var animation_player : AnimationPlayer = $AnimationPlayer

@onready
var mini_game_control_entity : MiniGameControlEntity = $Rover/Rover_Screen/Arms/Screen_arm/Screen_001/MiniGameControlEntity

@onready
var area_3d : Area3D = $Area3D

func _ready() -> void:
	animation_player.play("fold_in_screen")
	
	$Label3D.text = rover_name
	$PlayerDetectionZone/MarkerSprite.text = rover_name
	
	area_3d.body_entered.connect(_on_body_entered)
	area_3d.body_exited.connect(_on_body_exited)
	
	if mini_games[current_mini_game] != null:
		mini_game_control_entity.load_mini_game(mini_games[current_mini_game])
		mini_game_control_entity.mini_game_finished.connect(_on_mini_game_finished)
		
	rover_repaired.connect(_on_rover_repaired)

func _on_mini_game_finished() -> void:
	current_mini_game += 1
		
	if mini_games.size() <= current_mini_game:
		rover_repaired.emit()
	else:
		mini_game_control_entity.load_mini_game(mini_games[current_mini_game])

func _on_body_entered(body : Node3D) -> void:
	if body is Lagomorph:
		animation_player.play("fold_out_screen")

func _on_body_exited(body : Node3D) -> void:
	if body is Lagomorph:
		animation_player.play("fold_in_screen")
 
func _on_rover_repaired() -> void:
	mini_game_control_entity.unload_mini_game()
	
	$Fire.stop_fire()
	$Fire/Fire.stop_fire()
	$Fire/Fire2.stop_fire()
