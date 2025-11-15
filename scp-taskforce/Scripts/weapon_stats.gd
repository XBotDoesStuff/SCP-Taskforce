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

@export_category("Visuals")
@export var sprite : SpriteFrames
@export var sprite_offset : Vector2
@export var muzzle_offset : Vector2
