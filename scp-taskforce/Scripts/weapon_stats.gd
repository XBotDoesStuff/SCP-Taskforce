class_name WeaponStats
extends Resource

@export_category("Stats")
@export var fire_rate : float
@export var pierce : int
@export var damage : float
@export var mag_size : int
@export var spread : float
@export var reload_time : float

@export_category("Projectiles")
@export var proj_scene : PackedScene
@export var proj_count : int

@export_category("Visual/Audio")
@export var sprite : SpriteFrames
@export var sprite_offset : Vector2
@export var muzzle_offset : Vector2
@export var reload_sound : AudioStream
@export var fire_sound : AudioStream

@export_category("Special")
@export var refill_rate : float = 0.0
@export var refill_count : int = 0
