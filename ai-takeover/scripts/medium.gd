extends TextureButton



func _on_pressed() -> void:
	GlobalVariables.difficulty = "medium"
	print(GlobalVariables.difficulty)
	GlobalVariables.word_speed = 15
