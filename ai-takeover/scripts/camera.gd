extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var main = get_tree().current_scene
	if main: 
		main.i_am_current.connect(_on_current_found)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_current_found(body) -> void: 
	global_position = body
