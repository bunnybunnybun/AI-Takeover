extends Node2D
var word_array: Array = []
var phrases: Array = [
	["I", "Want", "The"]
]
var score = 0

var can_pickup = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_level_load()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#print("Score: ", score)
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
	if !can_pickup:
		return
	can_pickup = false
	word_array.append(word.name)
	var exceptions = []
	for word_node in get_node_or_null("River").get_children():
		if word_node == null:
			continue
		for piece in word_node.get_children():
			if is_instance_of(piece, VisibleOnScreenNotifier2D) and piece.is_on_screen():
				exceptions.append(word_node)
	get_node_or_null("River").shuffle_positions(exceptions)
	
	word.queue_free()
	get_tree().create_timer(0.2).timeout.connect(func():
		can_pickup = true
	)
