extends Node2D
var word_array: Array = []
var phrases: Array = [
	[&"Free", &"Road"],
	[&"Free"],
	[&"President"],
	[&"Road"]
]
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_level_load()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	print("Score: ", score)
	for i in range(len(word_array)):
		for j in range(i+1, len(word_array) + 1):
			if word_array.slice(i,j) in phrases:
				score += 1	
			for k in range(i,j+1):
				word_array.remove_at(k)
		
func _level_load ()-> void: 
	var words = get_node_or_null("River")
	if words: 
		words.word_pushed.connect(_on_word_pushed)
		
func _on_word_pushed(word) -> void: 
	word_array.append(word.name)
	word.queue_free()
