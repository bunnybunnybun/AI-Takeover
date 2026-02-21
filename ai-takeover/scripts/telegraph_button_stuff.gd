extends Control

@onready var time_held = 0
@onready var hold_time = 0.3

func _ready():
	set_process_mode(Node.PROCESS_MODE_ALWAYS)

func _process(delta):
	if Input.is_action_pressed("telegraph_button"):
		time_held += delta
	if Input.is_action_just_released("telegraph_button"):
		if !time_held > hold_time:
			var short_event = InputEventAction.new()
			short_event.action = "ui_focus_next"
			short_event.pressed = true
			Input.parse_input_event(short_event)
			get_tree().create_timer(0).timeout.connect(short_release)

		if time_held > hold_time:
			var long_event = InputEventAction.new()
			long_event.action = "ui_accept"
			long_event.pressed = true
			Input.parse_input_event(long_event)
			get_tree().create_timer(0).timeout.connect(long_release)
		time_held = 0
		
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
