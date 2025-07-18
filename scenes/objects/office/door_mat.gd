extends Node2D

# Conditions
@onready var allow_hover : bool = false
@onready var is_hovering : bool = false

# Positions
@onready var initial_position: Vector2 = position
@onready var moved_postion: Vector2 = Vector2(position.x + 20, position.y - 40)

# Collectible
#@onready var office_key : Node2D = $office_key_collectible

func _ready():
	pass
	#office_key.visible = false

func _on_interaction_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if (event is InputEventMouseButton and event.pressed && allow_hover && is_hovering):
		if position == initial_position:
			position = moved_postion
		#	office_key.visible = false
			_update_cursor()
		else:
			position = initial_position
		#	office_key.visible = false
			_update_cursor()
		get_viewport().set_input_as_handled()


func _on_interaction_area_mouse_entered() -> void:
	is_hovering = true
	_update_cursor()

func _on_interaction_area_mouse_exited() -> void:
	is_hovering = false
	_update_cursor()

func _on_proximity_area_body_entered(_body: Node2D) -> void:
	allow_hover = true
	_update_cursor()

func _on_proximity_area_body_exited(_body: Node2D) -> void:
	allow_hover = false
	_update_cursor()

func _update_cursor():
	if is_hovering && allow_hover:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
