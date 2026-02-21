extends TextureButton

func _on_pressed() -> void:
	GlobalVariables.difficulty = "easy"
	print(GlobalVariables.difficulty)
	GlobalVariables.word_speed = 5
