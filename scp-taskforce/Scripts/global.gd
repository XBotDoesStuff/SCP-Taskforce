extends Control

@onready var alarm: AudioStreamPlayer = %alarm


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_tree().current_scene.name == "startscene":
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/testuntitled.dialogue"))


	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
