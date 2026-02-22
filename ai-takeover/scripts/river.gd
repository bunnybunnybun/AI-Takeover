extends Node2D

signal word_pushed

var label_nodes = []

var all

var count = len(GlobalVariables.good_words) + len(GlobalVariables.bad_words)
var max_distance = 500 * count

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	all = GlobalVariables.good_words.duplicate()
	all.append_array(GlobalVariables.bad_words)
	all.shuffle()
	for i in range(count):
		var word = all[i]
		
		var n = Node2D.new()
		n.name = word
		
		var l = Label.new()
		l.name = "Label"
		l.text = word
		l.add_theme_font_size_override("font_size", 60)
		
		
		n.position.x = i * max_distance / count + get_viewport_rect().position.x
		n.position.y = get_viewport_rect().size.y * 0.1 + get_viewport_rect().position.y
		
		n.add_child(l)
		l.add_to_group("labels")
		
		var r = Panel.new()
		r.name = "Panel"
		r.position.x = l.position.x - 18
		r.position.y = l.position.y - 10
				
		r.size.x = ThemeDB.fallback_font.get_string_size(word, HORIZONTAL_ALIGNMENT_LEFT, -1, 60).x + 36 
		r.size.y = 100
		
		var style = StyleBoxFlat.new()
		style.draw_center = false
		style.border_width_left = 8
		style.border_width_right = 8
		style.border_width_top = 8
		style.border_width_bottom = 8
		style.border_color = Color.REBECCA_PURPLE
		
		r.add_theme_stylebox_override("panel", style)
		
		r.add_theme_color_override("color", Color.REBECCA_PURPLE)
		
		n.add_child(r)
		
		var area_2d = Area2D.new()
		area_2d.name = "Area2D"
		area_2d.position = r.position + r.size / 2
		var collision_rect = CollisionShape2D.new()
		
		var rectangle_shape = RectangleShape2D.new()
		rectangle_shape.size = r.size
		
		collision_rect.shape = rectangle_shape
		collision_rect.position = Vector2.ZERO

		area_2d.add_child(collision_rect)
		area_2d.connect("area_entered", func(area):
			if area.is_in_group("word_pushed"):
				emit_signal("word_pushed", n)
		)
		
		n.add_child(area_2d)
		
		var notifier = VisibleOnScreenNotifier2D.new()
		notifier.set_rect(Rect2(rectangle_shape.size, Vector2.ZERO))
		notifier.name = word + "_notifier"
		
		n.add_child(notifier)
		
		add_child(n)
		
		label_nodes.append(n)
	shuffle_positions()


func shuffle_positions():
	var positions = []
	for node in label_nodes:
		if node == null:
			continue
		var notifier = node.get_node(node.name + "_notifier")
		if notifier.is_on_screen():
			continue
		for part in node.get_children():
			if is_instance_of(part, Label):
				positions.append(part.position.x)
				break
			
	positions.shuffle()
	var i = 0
	for node in label_nodes:
		if node == null:
			continue
			
		var notifier = node.get_node(node.name + "_notifier")
		if notifier.is_on_screen():
			continue

		var label = node.get_node("Label")
		var panel = node.get_node("Panel")
		var area_2d = node.get_node("Area2D")
		
		label.position.x = positions[i]
		panel.position.x = positions[i] - 18
		area_2d.position.x = panel.position.x + panel.size.x/2
		i += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	for node in label_nodes:
		if node == null:
			continue
			
		node.position.x += GlobalVariables.word_speed
		if node.position.x > max_distance + get_viewport_rect().position.x:
			node.position.x = get_viewport_rect().position.x - 200
