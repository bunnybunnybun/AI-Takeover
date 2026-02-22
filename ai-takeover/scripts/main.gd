extends Node
var word_array: Array = []

var bad_phrases: Array = [
	
]

var score = 0

var can_pickup = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_level_load()
	$Control.visible = false

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
	$speech_bubble/speech.text += str(word.name) + " "
	if $speech_bubble/speech.get_total_character_count() > 100:
		$Control.visible = true
		if score >= GlobalVariables.opponent_score:
			$Control/Label.text = "Congrats, the people liked your speech best!"
			$Control/Label2.visible = true
		elif score < GlobalVariables.opponent_score:
			$Control/Label.text = "YOU LOSE, LOL! People didn't like your speech..."
		#get_tree().change_scene_to_file("res://scenes/job_application.tscn")
		return
	can_pickup = false
	word_array.append(word.name)
	word.queue_free()
	await get_tree().create_timer(0.5).timeout
	can_pickup = true
