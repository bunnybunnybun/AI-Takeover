extends TextureButton

func _on_pressed() -> void:
	$"../".visible = false
	$"../../settings_container".visible = true
