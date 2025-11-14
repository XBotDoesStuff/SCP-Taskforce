extends Button
@onready var audio_stream_player: AudioStreamPlayer = $scream
@onready var main_buttons: VBoxContainer = $MainButtons

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_options_pressed():
	$scream.play()
	
