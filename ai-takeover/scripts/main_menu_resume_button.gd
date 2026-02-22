extends TextureButton

func _on_pressed() -> void:
	var main = get_tree().current_scene
	var main_menu = main.get_node_or_null("main_menu")
	var VBoxContainer = main_menu.get_node_or_null("VBoxContainer")
	var Settings_container = main_menu.get_node_or_null("settings_container")
	Settings_container.visible = false
	VBoxContainer.visible = true
