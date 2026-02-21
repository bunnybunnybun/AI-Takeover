extends TextureButton

@onready var pause_menu = $"../../"
@onready var is_fading_out = false

func _on_pressed():
	$"../../AnimationPlayer".play_backwards("pause_menu_fade_in")
	is_fading_out = true

func _on_animation_player_animation_finished(anim_name):
	if pause_menu.visible == true and is_fading_out == true:
		$"../../main_container".visible = true
		$"../".visible = false
		pause_menu.visible = false
		is_fading_out = false
		get_tree().paused = false
