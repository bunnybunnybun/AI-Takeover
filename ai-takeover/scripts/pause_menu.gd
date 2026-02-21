extends Control
@onready var pause_menu = $"."

func _ready():
	pause_menu.visible = false
	
func _input(event):
	if pause_menu.visible == false:
		if Input.is_action_pressed("ui_accept"):
			pause()

func pause():
	pause_menu.visible = true
	get_tree().paused = true
	
#func resume():
	#pause_menu.visible = false
	#get_tree().paused = false
