class_name Player
extends CharacterBody2D

@export var speed = 400.0
@export var max_hp = 100
signal game_over
@onready var weapon = $Weapon

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
	global.player = self
	if global.saved_health:
		$Health.health = global.saved_health
	else:
		$Health.health = max_hp
	if global.saved_weapon_inv:
		$Weapon.weapon_inv = global.saved_weapon_inv

func equip_weapon(weapon : WeaponInstance):
	if not weapon in $Weapon.weapon_inv:
		$Weapon.weapon_inv.append(weapon)
		print(str($Weapon.weapon_inv))

func get_equipped_weapon():
	return $Weapon.equipped_weapon

func get_weapon_inv():
	return $Weapon.weapon_inv

func get_current_hp():
	return $Health.health

func set_weapon_inv(weapon_inv : Array[WeaponInstance]):
	$Weapon.weapon_inv = weapon_inv

func set_current_hp(health):
	$Health.health = health
