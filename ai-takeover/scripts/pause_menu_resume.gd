extends TextureButton

@onready var pause_menu = $"../../"

func _on_pressed():
	print("huh")
	pause_menu.visible = false
