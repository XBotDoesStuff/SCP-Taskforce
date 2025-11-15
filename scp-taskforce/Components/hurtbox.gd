class_name Hurtbox
extends Area2D

signal recieved_damage(value: float)

@export var health : Health

func _ready() -> void:
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox : Hitbox):
	print("collision")
	take_damage(hitbox.damage)

func take_damage(damage):
	health.health -= damage
	recieved_damage.emit(damage)
