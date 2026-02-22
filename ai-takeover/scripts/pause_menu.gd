extends Control
@onready var pause_menu = $"."

func _ready():
	pause_menu.visible = false
	
func _input(_event):
	if pause_menu.visible == false:
		if Input.is_action_pressed("ui_accept"):
			pause()

func pause():
	pause_menu.visible = true
	get_node("main_container").grab_focus()
	$AnimationPlayer.play("pause_menu_fade_in")
	get_tree().paused = true
