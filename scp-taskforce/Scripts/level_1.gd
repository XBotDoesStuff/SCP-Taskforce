extends Node2D

@export var dog_stats : EnemyStats
@export var hit_thingy : Shape2D
@export var dog : PackedScene
var score


func _on_mob_spawn_timeout() -> void:
	var new_dog = dog.instantiate()
	new_dog.stats = dog_stats
	new_dog.hitbox_shape = hit_thingy
	
	var spawn_location = $DogSpawner/PathFollow2D
	spawn_location.progress_ratio = randf()
	
	new_dog.position = spawn_location.position
	
	add_child(new_dog)
