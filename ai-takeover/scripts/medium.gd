extends TextureButton

func _on_pressed() -> void:
	GlobalVariables.difficulty = "medium"
	GlobalVariables.word_speed = 15
	GlobalVariables.hand_speed = 2
