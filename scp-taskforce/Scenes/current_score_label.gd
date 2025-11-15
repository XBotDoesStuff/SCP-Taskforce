extends RichTextLabel

var default_text = "Current Score: "
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var text = str(default_text, str(global.current_score))
	self.text = (text)
