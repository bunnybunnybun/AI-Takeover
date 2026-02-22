extends TextureButton

func _on_pressed():
	$"../".visible = false
	$"../../main_container".visible = true
