extends Label

var score_change = 60

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if int(text) > 0:
		add_theme_color_override("font_color", Color.GREEN)
	if int(text) < 0:
		add_theme_color_override("font_color", Color.RED)
	if int(text) == 0:
		add_theme_color_override("font_color", Color.GRAY)
	score_change -= 1
	if score_change == 0:
		score_change = 60
		var _player_score = int($"..".text)
		var diff_score = RandomNumberGenerator.new().randi_range(-1, 1)
		text = str(int(text) + diff_score)
		
		
