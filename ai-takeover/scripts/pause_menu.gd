extends Control
@onready var pause_menu = $"."

func _ready():
	pause_menu.visible = false
	
func _input(event):
	if Input.is_action_pressed("ui_accept"):
		if pause_menu.visible == false:
			pause_menu.visible = true
		else:
			pause_menu.visible = false
