extends Node2D

class_name BuildingInterior

signal exit_building

@onready
var door_button : Button = $DoorButton

@onready
var hologram_text : Label = $HologramText

func _ready() -> void:
	door_button.pressed.connect(_on_door_button_pressed)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func set_screen_text(text : String) -> void:
	hologram_text.text = text

func _on_door_button_pressed() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	exit_building.emit()
	queue_free()
