extends Node2D

var start_dialogue = load("res://Dialogue/testuntitled.dialogue")

var saved_equipped_weapon : WeaponInstance
var saved_weapon_inv : Array[WeaponInstance]
var saved_health : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_tree().current_scene.name == "startscene":
		DialogueManager.show_dialogue_balloon(start_dialogue)


func change_scene(scene_path : String):
	if saved_health or saved_weapon_inv or saved_equipped_weapon:
		save_player_data()
	print("THIS IS BEING CALLED" + str(is_inside_tree()))
	get_tree().change_scene_to_file(scene_path)
	if saved_health or saved_weapon_inv or saved_equipped_weapon:
		load_player_data()

func save_player_data():
	var player : Player = get_tree().get_first_node_in_group("Player")
	saved_equipped_weapon = player.get_equipped_weapon()
	saved_weapon_inv = player.get_weapon_inv()
	saved_health = player.get_current_hp()

func load_player_data():
	var player : Player = get_tree().get_first_node_in_group("Player")
	player.set_current_hp(saved_health)
	player.equip_weapon(saved_equipped_weapon)
	player.set_weapon_inv(saved_weapon_inv)
var high_score = 0
var current_score: int
var previous_score: int
