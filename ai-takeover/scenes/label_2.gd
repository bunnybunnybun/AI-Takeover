extends Label

func _input(event):
	if event.is_action_pressed("ui_focus_next") and $"../Label2".visible == true:
		get_tree().change_scene_to_file("res://scenes/job-pt2.tscn")
