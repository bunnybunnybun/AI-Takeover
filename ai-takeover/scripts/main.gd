extends Node2D
var word_array: Array = []
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_level_load()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if word_array.size() == 5:
		if word_array == ["I","Will","Help","The","Nation"]:
			score += 1
		
func _level_load ()-> void: 
	var words = get_node_or_null("words")
	if words: 
		for word in words: 
			word.word_pushed.connect(_on_word_pushed)
func _on_word_pushed(word) -> void: 
	word_array.append(word.name)
	print(word_array)
