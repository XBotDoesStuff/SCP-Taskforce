extends Node2D

@onready var weapon: Node2D = $"../Weapon"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_ammo()

func update_ammo():
	$Ammo.text = "AMMO: " + str(weapon.current_ammo) + "/" + str(weapon.mag_size)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_weapon_weapon_fired() -> void:
	update_ammo()

func _on_weapon_weapon_reload() -> void:
	$Ammo.text = "RELOADING"

func _on_weapon_reload_finished() -> void:
	update_ammo()
