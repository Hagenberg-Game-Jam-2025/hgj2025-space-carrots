class_name UIController
extends Node

@onready var _interaction_hint : Label = $InteractionHint
@onready var _battery_bar : TextureProgressBar = $Battery/TextureProgressBar
@onready var _death_panel : Panel = $DeathPanel
@onready var _hurt_panel : Panel = $HurtPanel
@onready var _hurt_effect_timer : Timer = $HurtPanel/HurtEffectTimer
var trauma_time : float = 0

func _ready() -> void:
	_interaction_hint.visible = false
	_battery_bar.value = _battery_bar.max_value
	_death_panel.visible = false
	_hurt_panel.visible = false
	_hurt_effect_timer.one_shot = true
	_hurt_effect_timer.timeout.connect(_on_hurt_effect_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if not _hurt_effect_timer.is_stopped():
		var time_left : float = _hurt_effect_timer.time_left
		var modulation : float
		if time_left < trauma_time * 0.5:
			modulation = smoothstep(0.0, trauma_time * 0.5, time_left)
		else:
			modulation = smoothstep(trauma_time * 0.5, 0.0, time_left)
		modulation *= 0.3
		_hurt_panel.modulate = Color(1.0, 1.0, 1.0, modulation)

func show_interaction_hint(show : bool) -> void:
	_interaction_hint.visible = show

func set_battery_charge(fraction : float) -> void:
	_battery_bar.value = 0.5 + floor(fraction * _battery_bar.max_value)

func display_hurt_effect(drama_level : int) -> void:
	trauma_time = drama_level * 0.3
	_hurt_panel.visible = true
	_hurt_panel.modulate = Color(1.0, 1.0, 1.0, 0.1 + trauma_time)
	_hurt_effect_timer.start(trauma_time)
	
func _on_hurt_effect_timeout() -> void:
	_hurt_panel.visible = false

func show_death_screen() -> void:
	_death_panel.visible = true
