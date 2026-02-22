extends TextureButton

func _on_pressed():
	print("pressed")
	get_tree().change_scene_to_file("res://scenes/main.tscn")
