extends Node2D
var cur_button = 0
var button_array = []
var loading = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("ready entered")
	var buttons = get_node_or_null("buttons")
	if buttons: 
		for button in buttons.get_children(): 
			print("ented for loop")
			button_array.append(button)
			button.is_clicked.connect(_on_click)
			button.is_short_clicked.connect(_on_short_click)
		update_button_focus()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
		
func _on_click (button) -> void: 
	print("connected")
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
func _on_short_click (button_number) -> void:
	cur_button += 1
	if cur_button >= button_array.size():
		cur_button = 0
	update_button_focus()
func update_button_focus() -> void: 
	for r in range(button_array.size()):
		var button_node = button_array[r]
		var animation_sprite_2d = button_node.get_node_or_null("button2")
		if animation_sprite_2d:
			if r == cur_button:
				animation_sprite_2d.visible = true
			else:
				animation_sprite_2d.visible = false
				
	
	
	
	
