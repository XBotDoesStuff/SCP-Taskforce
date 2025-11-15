class_name Hitbox
extends Area2D

@export var damage : float = 10
signal entered_hurtbox

func _ready() -> void:
	connect("area_entered", _on_area_entered)

func _on_area_entered(area: Hurtbox) -> void:
	entered_hurtbox.emit()
