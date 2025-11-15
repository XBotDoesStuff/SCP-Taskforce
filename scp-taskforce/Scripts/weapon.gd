extends Node2D

signal weapon_fired
signal weapon_reload
signal reload_finished
signal refresh_ammo_stat

@export var weapon_inv : Array[WeaponInstance] = []

@export var stats : WeaponStats:
	set(value):
		stats = value
		call_deferred("load_weapon_visuals")
		call_deferred("load_weapon_stats")

var equipped_weapon : WeaponInstance

var can_fire : bool = true
var reloading : bool = false

var dry_fire = load("res://Assets/Audio/dry_fire.wav")

var mag_size : int
var current_ammo : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	equipped_weapon = WeaponInstance.new(stats)
	print(str(equipped_weapon))
	load_weapon_visuals()
	load_weapon_stats()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("primary_action"):
		if can_fire and current_ammo > 0 and not reloading:
			fire()
		if current_ammo == 0 and not $DryFire.playing and not reloading:
			$DryFire.play()
	
	if Input.is_action_just_pressed("reload") and stats.reload_time != -1:
		if current_ammo < mag_size:
			reload()
	
	if Input.is_action_just_pressed("swap_weapon"):
		swap_weapon()

func swap_weapon():
	if weapon_inv.is_empty():
		return
	weapon_inv.append(equipped_weapon)
	equipped_weapon = weapon_inv.pop_front()
	
	stats = equipped_weapon.stats
	current_ammo = equipped_weapon.current_ammo
	print(str(weapon_inv))
	refresh_ammo_stat.emit()

func fire():
	var projectile = stats.proj_scene.instantiate()
	projectile.damage = stats.damage
	projectile.global_transform = $Muzzle.global_transform
	var deviation = deg_to_rad(stats.spread) / 2
	projectile.global_rotation += randf_range(-deviation, deviation)
	get_tree().root.add_child(projectile)
	
	$FireRate.start()
	can_fire = false
	current_ammo -= 1
	equipped_weapon.current_ammo = current_ammo
	emit_signal("weapon_fired")
	
	if stats.fire_sound:
		$FireSound.play(0)

func reload():
	$Reload.start()
	current_ammo = 0
	reloading = true
	emit_signal("weapon_reload")
	if stats.reload_sound:
		$ReloadSound.play()

func load_weapon_visuals():
	$AnimatedSprite2D.sprite_frames = stats.sprite
	$AnimatedSprite2D.offset = stats.sprite_offset
	$Muzzle.position = stats.muzzle_offset

func load_weapon_stats():
	$Reload.wait_time = stats.reload_time
	$FireRate.wait_time = stats.fire_rate
	mag_size = stats.mag_size
	if equipped_weapon:
		current_ammo = equipped_weapon.current_ammo
	else:
		current_ammo = mag_size
	$ReloadSound.stream = stats.reload_sound
	$FireSound.stream = stats.fire_sound
	
	if stats.refill_rate:
		$Refill.wait_time = stats.refill_rate
		$Refill.start()
	else:
		$Refill.stop()

func _on_fire_rate_timeout() -> void:
	can_fire = true

func _on_reload_timeout() -> void:
	current_ammo = mag_size
	reloading = false
	emit_signal("reload_finished")

# ---------- SPECIAL FUNCTIONS FOR SPECIAL WEAPONS ----------
func _on_refill_timeout():
	if can_fire:
		current_ammo = clamp(current_ammo + stats.refill_count, 0, mag_size)
		refresh_ammo_stat.emit()
