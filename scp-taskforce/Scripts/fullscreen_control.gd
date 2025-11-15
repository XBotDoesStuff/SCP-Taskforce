extends CheckBox
@onready var main_buttons: VBoxContainer = $MainButtons
@onready var scream: AudioStreamPlayer = $"../../MainButtons/Button2/scream"
@onready var yelp: AudioStreamPlayer = $"../../MainButtons/Button2/yelp"




func _on_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		scream.play()
	
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		yelp.play()
