@tool
extends Node2D

signal weapon_fired
signal weapon_reload
signal reload_finished

@export var stats : WeaponStats:
	set(value):
		stats = value
		call_deferred("load_weapon_visuals")

var can_fire : bool = true
var reloading : bool = false

var mag_size : int
var current_ammo : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_weapon_visuals()
	load_weapon_stats()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("primary_action"):
		if can_fire and current_ammo > 0 and not reloading:
			fire()
	
	if Input.is_action_just_pressed("reload"):
		if current_ammo < mag_size:
			reload()

func fire():
	var projectile = stats.proj_scene.instantiate()
	get_tree().root.add_child(projectile)
	projectile.global_transform = $Muzzle.global_transform
	var deviation = deg_to_rad(stats.spread) / 2
	projectile.global_rotation += randf_range(-deviation, deviation)
	
	$FireRate.start()
	can_fire = false
	current_ammo -= 1
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
	current_ammo = mag_size
	$ReloadSound.stream = stats.reload_sound
	$FireSound.stream = stats.fire_sound

func _on_fire_rate_timeout() -> void:
	can_fire = true

func _on_reload_timeout() -> void:
	current_ammo = mag_size
	reloading = false
	emit_signal("reload_finished")
