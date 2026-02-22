extends TextureButton

func _on_pressed():
	$"../".visible = false
	$"../../VBoxContainer".visible = true
