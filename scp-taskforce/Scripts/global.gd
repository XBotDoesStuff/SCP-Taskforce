extends Node2D

var start_dialogue = load("res://Dialogue/testuntitled.dialogue")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_tree().current_scene.name == "startscene":
		DialogueManager.show_dialogue_balloon(start_dialogue)


func change_scene(scene_path : String):
	print("THIS IS BEING CALLED" + str(is_inside_tree()))
	get_tree().change_scene_to_file(scene_path)
