extends Node2D

signal word_pushed

var words = [
	"How",
	"Is",
	"Why",
	"When",
	"What",
	"And",
	"Will",
	"I",
	"Not",
	"Catacombs",
	"Nation",
	"President",
	"Eat",
	"To",
	"Or",
	"I’m",
	"Scared",
	"Can",
	"Not",
	"The",
	"Clean",
	"Hackclub",
	"Murder",
	"Couch",
	"Cool",
	"Want",
	"Touch",
	"Money",
	"Everyone",
	"No one",
	"TVs",
	"Shower",
	"Door",
	"School",
	"Logical",
	"Emotional",
	"Help",
	"Bank",
	"Free",
	"Sure",
	"Make",
	"Has",
	"Tablet",
	"Street",
	"Road",
	"Restaurant",
	"Food",
	"Water",
	"Pants",
    "House"
]

var label_nodes = []

var max_distance = 500 * len(words)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(len(words)):
		var word = words[i]
		
		var n = Node.new()
		n.name = word
		
		var l = Label.new()
		l.text = word
		l.add_theme_font_size_override("font_size", 60)
		l.position.x = i * max_distance / len(words) + get_viewport_rect().position.x
		l.position.y = get_viewport_rect().size.y * 0.1 + get_viewport_rect().position.y
		
		n.add_child(l)
		l.add_to_group("labels")
		
		var r = Panel.new()
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
		area_2d.position = r.position + r.size / 2
		var collision_rect = CollisionShape2D.new()
		
		var rectangle_shape = RectangleShape2D.new()
		rectangle_shape.size = r.size
		
		collision_rect.shape = rectangle_shape
		collision_rect.position = Vector2.ZERO

		area_2d.add_child(collision_rect)
		area_2d.connect("area_entered", func(area):
			emit_signal("word_pushed", n)
		)
		
		n.add_child(area_2d)
		
		var notifier = VisibleOnScreenNotifier2D.new()
		notifier.set_rect(Rect2(rectangle_shape.size, Vector2.ZERO))
		notifier.name = word + "_notifier"
		
		n.add_child(notifier)
		
		add_child(n)
		
		label_nodes.append(n)

func shuffle_positions(except: Array):
	var positions = []
	for node in label_nodes:
		if node == null:
			continue
		if node in except:
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
		if node in except:
			continue
		for part in node.get_children():
			if !is_instance_of(part, Panel):
				part.position.x = positions[i]
			else:
				part.position.x = positions[i] - 18
		i += 1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	for node in label_nodes:
		if node == null:
			continue
		for part in node.get_children():
			part.position.x += 5
			if part.position.x > max_distance + get_viewport_rect().position.x:
				part.position.x = get_viewport_rect().position.x - 200
