extends Node2D
var cur_button = 0
var button_array = []
var loading = false
signal i_am_current

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var buttons = get_node_or_null("buttons")
	if buttons: 
		var children = buttons.get_children()
		for b in range(children.size()):
			var button = children[b]
			button_array.append(button)
			button.is_clicked.connect(_on_click)
			if b == 0:
				button.is_short_clicked.connect(_on_short_click)
		update_button_focus()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
		
func _on_click (button) -> void: 
	if button_array[cur_button]==button:
		var animation_button = button.get_node_or_null("button2")
		if animation_button.animation == "on":
			animation_button.play("on_to_off")
			await animation_button.animation_finished
			animation_button.play("off")
		elif animation_button.animation == "off":
			animation_button.play("off_to_on")
			await animation_button.animation_finished
			animation_button.play("on")
func _on_short_click (_button_number) -> void:
	if button_array.size() ==0: return
	cur_button += 1
	if cur_button >= button_array.size():
		cur_button = 0
	update_button_focus()
func update_button_focus() -> void: 
	for r in range(button_array.size()):
		var button_index = button_array[r]
		var animation_sprite_2d = button_index.get_node_or_null("button2")
		if animation_sprite_2d:
			if r == cur_button:
				button_index.on = true
				animation_sprite_2d.modulate = Color(2, 2, 2) 
				animation_sprite_2d.scale = Vector2(0.35,0.35)
				i_am_current.emit(button_index.global_position)
			else:
				button_index.on = false
				animation_sprite_2d.modulate = Color(0.2, 0.2, 0.2) 
				animation_sprite_2d.scale = Vector2(0.3,0.3)

				

func _on_button_button_down() -> void:
	get_tree().reload_current_scene()


func _on_button_2_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/job_application.tscn")
