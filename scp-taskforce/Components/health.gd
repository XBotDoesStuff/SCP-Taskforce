class_name Health
extends Node

signal max_health_changed(diff : float)
signal health_changed(diff : float)
signal health_depleted()

@export var max_health : float = 100 : set = set_max_health

@onready var health = max_health : set = set_health, get = get_health

func set_max_health(value : float):
	var clamped_value = 1 if value <= 0 else value
	
	if not clamped_value == max_health:
		var diff = clamped_value - max_health
		max_health = clamped_value
		max_health_changed.emit(diff)

func set_health(value : float):
	var clamped_value = clamp(value, 0, max_health)
	
	if not clamped_value == health:
		var diff = clamped_value - health
		health = clamped_value
		health_changed.emit(diff)
		
		if health <= 0:
			health_depleted.emit()

func get_health():
	return health
