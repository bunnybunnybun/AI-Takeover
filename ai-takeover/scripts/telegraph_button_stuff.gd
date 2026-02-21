extends Control

@onready var time_held = 0
func _process(delta):
	if Input.is_action_pressed("telegraph_button"):
		time_held += delta
	if Input.is_action_just_released("telegraph_button"):
		if !time_held > 0.5:
			print("1")
			var short_event = InputEventAction.new()
			short_event.action = "ui_focus_next"
			short_event.pressed = true
			Input.parse_input_event(short_event)
			get_tree().create_timer(0).timeout.connect(short_release)
		time_held = 0
	if time_held > 0.5:
		print("2")
		var long_event = InputEventAction.new()
		long_event.action = "ui_accept"
		long_event.pressed = true
		Input.parse_input_event(long_event)
		get_tree().create_timer(0).timeout.connect(long_release)
		
func long_release():
	var long_event = InputEventAction.new()
	long_event.action = "ui_accept"
	long_event.pressed = false
	Input.parse_input_event(long_event)
	
func short_release():
	var short_event = InputEventAction.new()
	short_event.action = "ui_focus_next"
	short_event.pressed = false
	Input.parse_input_event(short_event)
