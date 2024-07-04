extends LevelParent

@onready var player = $Player

func _ready():
	player.target_position = Vector2(1506, 744)

func _on_floor_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton && event.is_action_pressed("left_click"):
		player.move(event.position)

# DOOR CLICK
func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("left_click"):
		get_tree().change_scene_to_file("res://scenes/cutscene/intro_cutscene.tscn")
