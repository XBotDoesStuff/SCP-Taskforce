class_name Player
extends CharacterBody2D

@export var speed = 400.0
@export var max_hp = 100
signal game_over

func get_input():
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_dir * speed

func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	get_input()
	move_and_slide()

func _on_health_health_depleted() -> void:
	game_over.emit()
	queue_free()

func _ready() -> void:
	$Health.set_max_health(max_hp)
	print($Health.max_health)

func equip_weapon(weapon : WeaponInstance):
	if not weapon in $Weapon.weapon_inv:
		$Weapon.weapon_inv.append(weapon)
		print(str($Weapon.weapon_inv))
