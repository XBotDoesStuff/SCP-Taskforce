extends Control
@onready var main_buttons: VBoxContainer = $MainButtons
@onready var options: Panel = $Options


# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _ready():
	main_buttons.visible = true
	options.visible = false


func _on_start_pressed():
	get_tree().change_scene_to_file("res://startscene.tscn")
	


func _on_options_pressed():
	main_buttons.visible = false
	options.visible = true
	


func _on_exit_pressed():
	get_tree().quit()


func _on_return_options_pressed():
	_ready()
