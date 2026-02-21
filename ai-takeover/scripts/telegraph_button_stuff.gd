extends Control

@onready var time_held = 0
func _process(delta):
	if Input.is_action_pressed("ui_focus_next"):
		time_held += delta
	if Input.is_action_just_released("ui_focus_next"):
		time_held = 0
	if time_held > 0.5:
		time_held = 0
		var accept_event = InputEventAction.new()
		accept_event.action = "ui_accept"
		accept_event.pressed = true
		Input.parse_input_event(accept_event)
		get_tree().create_timer(0).timeout.connect(release)
		print("success")
		
		
func release():
	var accept_event = InputEventAction.new()
	accept_event.action = "ui_accept"
	accept_event.pressed = false
	Input.parse_input_event(accept_event)
	print("test")
