extends TextureButton
func _process(float):
	#print("is even in process?")
	if Input.is_action_just_pressed("ui_focus_next"):
		print("focus printed")
func _on_pressed():
	print("pressed")
	get_tree().change_scene_to_file("res://scenes/main.tscn")
#func _input(event: InputEvent) -> void:
	#print("press detected")
	#if event.is_action_pressed("ui_focus_next"):
		#get_tree().change_scene_to_file("res://scenes/main.tscn")
	
