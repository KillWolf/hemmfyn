extends LevelParent

func _ready():
	$Player.target_position = Vector2(1506, 744)

func _on_floor_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("left_click"):
		$Player.move(get_global_mouse_position())
