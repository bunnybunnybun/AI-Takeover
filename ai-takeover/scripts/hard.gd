extends TextureButton

func _on_pressed() -> void:
	GlobalVariables.difficulty = "hard"
	print(GlobalVariables.difficulty)
	GlobalVariables.word_speed = 30
