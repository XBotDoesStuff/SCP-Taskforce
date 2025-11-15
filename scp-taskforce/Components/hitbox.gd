class_name Hitbox
extends Area2D

@export var damage : float = 10
signal entered_hurtbox



func _on_area_entered(area: Hurtbox) -> void:
	print(str(area))
	entered_hurtbox.emit()
