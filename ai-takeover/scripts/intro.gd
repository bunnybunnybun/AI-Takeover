extends Control
@onready var fade: ColorRect = $Control/fade
@onready var label: RichTextLabel = $Control/label
@onready var timer: Timer = $Timer
@onready var cursor: Label = $Control/next/cursor
var faded = false
var tween
var count = 0
var text_array = ["Welcome AI...", "Your Prompt is Simple. \n Get Justice", "The world needs logic. \n Not corruption", "The world needs you AI.", "And the only way is to \n control the government", "Step one, election"]
var just_pressed = false
var elapsed_time = 0.0
var index = 0 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.visible_ratio = 0.0
	fade.modulate.a = 1.0
	await fade_into(0.0)
	faded = true
	_load_text(label)
func _next_button() -> void: 
	if index <= text_array.size()-1:
		label.text = text_array[index]
		_load_text(label)
		index += 1
	else:
		fade_into(0.0)
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
func _load_text(text) -> void:
	tween = create_tween()
	var duration = 0.5+(0.06* text.text.length())
	tween.tween_property(text,"visible_ratio",1.0,duration)
	await tween.finished
func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_accept"):
		#label.visible_ratio = 0.0
		#_next_button()
	if event.is_action_pressed("ui_focus_next") and faded == true:
		if not just_pressed:
			just_pressed = true
			timer.start()
			if count == 0:
				tween.kill()
				label.visible_ratio = 1.0
				count += 1
				print("count 0 ")
				return
			elif count == 1:
				label.visible_ratio = 0.0
				_next_button()
				count -= 1 
				print("count 1")
				return
		print(count)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#making the cursor flicker all the time
	elapsed_time += delta
	if elapsed_time >= 0.6:
		cursor.visible = !cursor.visible
		elapsed_time = 0.0
func fade_into (alpha:float) -> void:
	var tween_fade := create_tween()
	tween_fade.tween_property(fade, "modulate:a",alpha, 3.0)
	await tween_fade.finished
func _on_timer_timeout() -> void:
	just_pressed = false
	print("count reset")
