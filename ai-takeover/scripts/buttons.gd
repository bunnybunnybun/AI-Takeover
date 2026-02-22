extends Node2D
signal is_clicked
signal is_short_clicked
var on = false
var score = 0 
@onready var button2: AnimatedSprite2D = $button2
@onready var win: Node2D = $"../../win"
@onready var try_again: Node2D = $"../../try_again"
@onready var camera_2d: Camera2D = %Camera2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button2.animation = "off"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("is_clicked", self)
	if Input.is_action_just_pressed("ui_focus_next"):
		emit_signal("is_short_clicked",self.name)
	if self.name == "button5" and button2.animation == "on":
		show_results()
func show_results() -> void: 
	# 1. Reset Camera
	if camera_2d:
		camera_2d.position = Vector2.ZERO
		camera_2d.set_process(false)
	
	# 2. Reset score before counting
	score = 0
	
	# 3. Access the parent (WHITE) to check all siblings
	var all_blocks = get_parent().get_children()
	
	for block in all_blocks:
		# Find the AnimatedSprite2D on each block
		var sprite = block.get_node_or_null("button2")
		
		if sprite:
			# Check if that specific sprite is in the "on" animation
			if sprite.animation == "on":
				# We don't count the submit button (button5) as a point
				if block.name != "button5":
					score += 1
	
	# 4. Final logic check
	if score >= 3:
		win.visible = true
		try_again.visible = false
	else:
		win.visible = false
		try_again.visible = true
		
	
	
