extends Control

signal on_hoover

var cur_block = 0
var block_array = []
var selected_block = []
var is_hoovering = true 

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

func update_block_focus() -> void: 
	for r in range(block_array.size()):
		var block_node = block_array[r]
		if r == cur_block :
			block_node.self_modulate = Color(0.329, 0.329, 0.329, 1.0) # Pink
		elif selected_block.has(r):
			block_node.self_modulate = Color(0.832, 0.212, 0.585, 1.0) # Bright White
		else:
			block_node.self_modulate = Color(0.711, 0.711, 0.711, 1.0) # Pink
