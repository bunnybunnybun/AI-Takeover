extends Node2D
var word_array: Array = []

var bad_phrases: Array = [
	
]

var score = 0

var can_pickup = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_level_load()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Score.text = str(score)
	for i in range(len(word_array) - 1, -1, -1):
		#Special case
		if word_array[i] == "Hackclub":
			score += 9
		if word_array[i] in GlobalVariables.good_words:
			score += 1
			
		if word_array[i] in GlobalVariables.bad_words:
			score -= 1
		
		if word_array[i] in GlobalVariables.good_words or word_array[i] in GlobalVariables.bad_words:
			word_array.remove_at(i)

func _level_load ()-> void: 	
	var words = get_node_or_null("River")
	if words: 
		words.word_pushed.connect(_on_word_pushed)		
		
func _on_word_pushed(word) -> void: 
	if !can_pickup:
		return
	can_pickup = false
	word_array.append(word.name)
	get_node_or_null("River").shuffle_positions()
	word.queue_free()
	await get_tree().create_timer(0.2).timeout
	can_pickup = true
