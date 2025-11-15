class_name Bullet
extends Area2D

var speed = 1000
var time_to_live = 1
var friendly : bool = true
@export var damage : float = 10

func _ready() -> void:
	$Timer.wait_time = time_to_live
	$Timer.start()
	$Hitbox.damage = damage

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func on_timeout():
	queue_free()

func _on_hitbox_entered_hurtbox() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if not area.is_in_group("Player") and not area.is_in_group("Enemy") and not area.is_class("Hitbox"):
		queue_free()
