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

var labels = []

var max_distance = 500 * len(words)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(len(words)):
		var word = words[i]
		
		var word_group = []
		
		var n = Node.new()
		n.name = word
		
		var l = Label.new()
		l.text = word
		l.add_theme_font_size_override("font_size", 60)
		l.position.x = i * max_distance / len(words) + get_viewport_rect().position.x
		l.position.y = get_viewport_rect().size.y / 2 + get_viewport_rect().position.y
		
		n.add_child(l)
		word_group.append(l)
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
		word_group.append(r)
		
		var area_2d = Area2D.new()
		area_2d.global_position = r.position
		
		var collision_rect = CollisionShape2D.new()
		collision_rect.global_position.x = r.position.x
		collision_rect.global_position.y = r.position.y
		
		var rectangle_shape = RectangleShape2D.new()
		rectangle_shape.size = r.size
		
		collision_rect.shape = rectangle_shape
		
		area_2d.add_child(collision_rect)
		area_2d.connect("area_entered", func():
			emit_signal("word_pushed", n)
		)
		
		n.add_child(area_2d)
		
		add_child(n)
		
		labels.append(word_group)


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	for word_group in labels:
		for part in word_group:
			part.position.x += 5
			if part.position.x > max_distance + get_viewport_rect().position.x:
				part.position.x = get_viewport_rect().position.x - 200
	
