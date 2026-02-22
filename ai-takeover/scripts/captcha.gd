extends Control
signal on_hoover
var cur_block: int = 0
var block_array: Array = []
var selected_block: Array = []
@onready var try_again: Node2D = $"../try_again"
@onready var win: Node2D = $"../win"
@onready var timer: Timer = $"../Timer"
@onready var timer_label: Label = $"../timer_label"
var time_elapsed: float = 0.0 
func _process(delta: float) -> void:
	time_elapsed += delta
	var secs = 50 - int(time_elapsed) % 60
	timer_label.text = "Time:%s"%secs
	if secs == 0:
		timer_label.visible = false
		win.visible = false
		try_again.visible = true
		
func _ready() -> void:
	on_hoover.connect(update_block_focus)
	var nodes = get_node_or_null("WHITE")
	if nodes: 
		block_array = nodes.get_children()
		for block in block_array:
			block.pivot_offset = block.size / 2
		update_block_focus()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_focus_next"):
		cur_block = (cur_block + 1) % block_array.size()
		on_hoover.emit()

	if event.is_action_pressed("ui_accept"): 
		if selected_block.has(cur_block):
			selected_block.erase(cur_block)
		else:
			selected_block.append(cur_block)
		
		update_block_focus()
		check_captcha_completion()

func update_block_focus() -> void: 
	for r in range(block_array.size()):
		var block_node = block_array[r]
		if not block_node: continue

		var is_hovered = (r == cur_block)
		var is_selected = selected_block.has(r)

	
		if is_selected:
			block_node.self_modulate = Color(0.832, 0.212, 0.585)
		elif is_hovered:
			block_node.self_modulate = Color(0.329, 0.329, 0.329) 
		else:
			block_node.self_modulate = Color(0.711, 0.711, 0.711)

#VERY IMPORTANT CHECK

func check_captcha_completion() -> void:
	
	var pass_color = Color(0.832, 0.212, 0.585)
	var all_match = true
	
	for block in block_array:
		if not block.self_modulate.is_equal_approx(pass_color):
			all_match = false
			break
			
	if all_match and block_array.size() > 0:
		win.visible = true
		try_again.visible = false
		set_process_input(false)
		
