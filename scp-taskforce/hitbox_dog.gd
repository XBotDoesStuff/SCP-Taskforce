class_name HitboxDog
extends Hitbox

func _ready() -> void:
	connect("area_entered", _on_area_entered)

func _on_area_entered(area: Hurtbox) -> void:
	entered_hurtbox.emit()
	print("collision")
