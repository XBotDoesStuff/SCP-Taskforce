extends Node2D

@onready var weapon: Node2D = $"../Weapon"
@onready var health: Health = $"../Health"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_ammo()
	update_health()

func update_ammo():
	$Ammo.text = "AMMO: " + str(weapon.current_ammo) + "/" + str(weapon.stats.mag_size)

func update_health():
	if health.get_health():
		$HealthBar.value = health.get_health()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_weapon_weapon_fired() -> void:
	update_ammo()

func _on_weapon_weapon_reload() -> void:
	$Ammo.text = "RELOADING"

func _on_weapon_reload_finished() -> void:
	update_ammo()

func _on_weapon_refresh_ammo_stat() -> void:
	update_ammo()

func _on_health_changed(diff):
	update_health()
