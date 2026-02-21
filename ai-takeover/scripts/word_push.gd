extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("word_pusher")
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_focus_next") and !visible:
		visible = true
		print("button pressed")
		animated_sprite_2d.frame = 0 
		animated_sprite_2d.play("hand_grab")
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position + Vector2(0,-200), 0.25)
		tween.tween_property(self, "position", position, 0.25)
		await animated_sprite_2d.animation_finished
		await get_tree().create_timer(0.3).timeout
		visible = false
