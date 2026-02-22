extends Node2D
signal is_clicked
signal is_short_clicked
@onready var button2: AnimatedSprite2D = $button2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button2.animation = "on"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("is_clicked", self)
	if Input.is_action_just_pressed("ui_focus_next"):
		emit_signal("is_short_clicked",self.name)
