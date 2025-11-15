class_name WeaponInstance
extends Node

var stats : WeaponStats
var current_ammo : int

func _init(weapon_stats):
	stats = weapon_stats
	current_ammo = stats.mag_size
