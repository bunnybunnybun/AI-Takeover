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
		selected_block.contains(cur_block)
		update_block_focus()

func update_block_focus() -> void: 
	for r in range(block_array.size()):
		var block_node = block_array[r]
		if block_node:
			if selected_block.constains(r)
				block_node.self_modulate = Color(0.51, 0.502, 0.502, 1.0) # Bright White
			else:
				selected_block
			elif r == cur_block :
				block_node.self_modulate = Color(0.835, 0.208, 0.581, 1.0) # Pink
			else:
				block_node.self_modulate = Color(0.238, 0.238, 0.238, 1.0) # Pink
