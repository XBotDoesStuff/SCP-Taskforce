extends Node2D

var start_dialogue = load("res://Dialogue/testuntitled.dialogue")

var saved_equipped_weapon : WeaponInstance
var saved_weapon_inv : Array[WeaponInstance]
var saved_health : float

var player : Player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_tree().current_scene.name == "startscene":
		DialogueManager.show_dialogue_balloon(start_dialogue)


func change_scene(scene_path : String):
	print(player)
	save_player_data()
	get_tree().change_scene_to_file(scene_path)

func save_player_data():
	saved_equipped_weapon = player.get_equipped_weapon()
	saved_weapon_inv = player.get_weapon_inv()
	saved_health = player.get_current_hp()
