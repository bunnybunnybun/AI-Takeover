extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("word_pusher")
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_focus_next"):
		visible = true
		print("button pressed")
		animated_sprite_2d.frame = 0 
		animated_sprite_2d.play("hand_grab")
		await animated_sprite_2d.animation_finished
		await get_tree().create_timer(0.3).timeout
		visible = false
