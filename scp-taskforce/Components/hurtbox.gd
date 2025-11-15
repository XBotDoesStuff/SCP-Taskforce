class_name Hurtbox
extends Area2D

signal recieved_damage(value: float)

@export var health : Health

func _ready() -> void:
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox : Hitbox):
	if hitbox != null:
		health.health -= hitbox.damage
		recieved_damage.emit(hitbox.damage)
