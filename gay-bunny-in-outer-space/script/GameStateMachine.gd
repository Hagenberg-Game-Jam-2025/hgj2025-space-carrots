class_name GameStateMachine
extends Node

static var MAIN_MENU : String = "res://scene/MainMenu.tscn"
static var SCENE_INTERACTION_TEST : String = "res://scene/test-scene/mars/mars.tscn"
static var SCENE_CREDITS : String = "res://scene/Credits.tscn"

signal player_died

@export var player : Player
@export var creatures : Array[Creature]
@export var sfxPlayer : SfxPlayer
@export var musicPlayer : MusicPlayer
@export var environment : WorldEnvironment

func _ready() -> void:
	sfxPlayer.finished.connect(_on_death_sound_finished_playing)
	for creature : Creature in creatures:
		creature.on_hurt.connect(_process_creature_hurt)
		creature.on_death.connect(_process_creature_death)

func _process(delta : float) -> void:
	pass

func _process_creature_hurt(creature : Creature, amount : int) -> void:
	if creature == player.main_bound_entity:
		var relative_health : float = float(creature.health) / float(creature.max_health)
		player.ui_controller.set_battery_charge(relative_health)
		if creature.health > 0:
			player.ui_controller.display_hurt_effect(min(amount, 3))

func _process_creature_death(creature : Creature) -> void:
	if creature == player.main_bound_entity:
		player_died.emit()
		player.ui_controller.show_death_screen()
		if sfxPlayer != null:
			sfxPlayer.play_death_sound()
			await get_tree().create_timer(15).timeout
			get_tree().change_scene_to_file(MAIN_MENU)
		if musicPlayer != null:
			musicPlayer.autoplay = false
			musicPlayer.stop()

func _on_death_sound_finished_playing() -> void:
	get_tree().change_scene_to_file(MAIN_MENU)
