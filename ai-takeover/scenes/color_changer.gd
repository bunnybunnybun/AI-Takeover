extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if int(text) > 0:
		add_theme_color_override("font_color", Color.GREEN)
	if int(text) < 0:
		add_theme_color_override("font_color", Color.RED)
	if int(text) == 0:
		add_theme_color_override("font_color", Color.GRAY)
