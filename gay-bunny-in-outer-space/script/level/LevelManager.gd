extends Node

class_name LevelManager

@export
var planet_base_interior_scene : PackedScene

@export
var levels : Array[PackedScene]

@export
var level_container : Node3D

@export
var planet_base_building : PlanetBaseBuilding

var current_level : int = 0

func _ready() -> void:
	load_level()
	planet_base_building.enter_building.connect(_on_building_entered)

func load_level() -> void:
	for node : Node in level_container.get_children():
		node.queue_free()
	
	if (current_level > levels.size() - 1):
		return
	
	var level_instance : Level = levels[current_level].instantiate()
	
	level_instance.level_complete.connect(_on_level_completed)
	level_container.add_child(level_instance)

func _on_level_completed() -> void:
	planet_base_building.is_unlocked = true
	current_level += 1

func _on_building_entered() -> void:
	var planet_base_interior_scene_instance : Node = planet_base_interior_scene.instantiate()
	planet_base_interior_scene_instance.exit_building.connect(_on_building_exited)
	get_tree().root.add_child(planet_base_interior_scene_instance)
	
	print("level loaded")

func _on_building_exited() -> void:
	
	print("EXIT")
	load_level()
	planet_base_building.is_unlocked = false
