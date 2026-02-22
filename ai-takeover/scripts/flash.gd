extends Control
@onready var timer: Timer = $Timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var cooldown: Timer = $cooldown

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.modulate.a = 0.0
	timer.wait_time = randf_range(20.0,40.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
func _on_timer_timeout() -> void:
	animated_sprite_2d.frame = randi_range(0,4)
	var tween = create_tween()
	tween.tween_property(animated_sprite_2d, "modulate:a", 1.0, 0.7)
	timer.wait_time = randf_range(20.0,40.0)
	cooldown.start()

func _on_cooldown_timeout() -> void:
	var tween = create_tween()
	tween.tween_property(animated_sprite_2d, "modulate:a", 0.0, 0.7)
	cooldown.wait_time = randf_range(0.5,4.0)
