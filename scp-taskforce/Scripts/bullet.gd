class_name Bullet
extends Area2D

var speed = 1000
var time_to_live = 1
var friendly : bool = true
var damage : float

func _ready() -> void:
	$Timer.wait_time = time_to_live
	$Timer.start()
	$Hitbox.damage = damage

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if not friendly:
			queue_free()
	elif body.is_in_group("Enemy"):
		if friendly:
			queue_free()
	else:
		queue_free()

func on_timeout():
	queue_free()
