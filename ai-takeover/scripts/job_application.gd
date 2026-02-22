extends Node2D
var cur_button = 0
var button_array = []
var loading = false
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
	print("long click")
	if button_array[cur_button]==button:
		var animation_button = button.get_node_or_null("button2")
		print(animation_button.animation)
		if animation_button.animation == "on":
			animation_button.play("on_to_off")
			await animation_button.animation_finished
			animation_button.play("off")
		elif animation_button.animation == "off":
			animation_button.play("off_to_on")
			await animation_button.animation_finished
			animation_button.play("on")
func _on_short_click (_button_number) -> void:
	print("short click")
	if button_array.size() ==0: return
	cur_button += 1
	if cur_button >= button_array.size():
		cur_button = 0
	print("current button is ", cur_button)
	update_button_focus()
func update_button_focus() -> void: 
	for r in range(button_array.size()):
		var animation_sprite_2d = button_array[r].get_node_or_null("button2")
		if animation_sprite_2d:
			if r == cur_button:
				animation_sprite_2d.modulate = Color(2, 2, 2) 
				animation_sprite_2d.scale = Vector2(0.35,0.35)
			else:
				animation_sprite_2d.modulate = Color(0.2, 0.2, 0.2) 
				animation_sprite_2d.scale = Vector2(0.3,0.3)

				
	
	
	
	
