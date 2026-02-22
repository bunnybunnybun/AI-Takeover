extends Node2D
const SLOW = 10
const MEDIUM = 20 
const FAST = 30 
var word_array_1: Array = ["Currently","In the past", "In the future","Furthermore", "As you can see" ]
var word_array_2: Array = ["the opposition", "our friends", "Bob", "You and I","Enchiladas"]
var word_array_3: Array = []
var bad_words: Array = [
	
]
var neutral_words:Array = [
"Currently",
"In the past",
"In the future",
"Furthermore", 
"As you can see",
"Enchiladas"
]
var good_words: Array = [
"our friends",
"You and I",
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
