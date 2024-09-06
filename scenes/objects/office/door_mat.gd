extends Control

@onready var initial_position: Vector2 = position
@onready var moved_postion: Vector2 = Vector2(576, 554)
@onready var textureRect: TextureRect = $TextureRect
@onready var allow_hover: bool = false
@onready var is_hovering: bool = false

func _on_gui_input(event):
	if (event is InputEventMouseButton
		and event.is_action_pressed("left_click")
		and is_hovering
		and allow_hover):
			if position == initial_position:
				position = moved_postion
			else:
				position = initial_position
			accept_event()


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		allow_hover = true

func _on_area_2d_body_exited(body):
	if body is CharacterBody2D:
		allow_hover = false

func _on_area_2d_mouse_entered():
	is_hovering = true

func _on_area_2d_mouse_exited():
	is_hovering = false

func _process(_delta):
	if is_hovering && allow_hover:
		textureRect.mouse_filter = Control.MOUSE_FILTER_PASS
		textureRect.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	else:
		textureRect.mouse_filter = Control.MOUSE_FILTER_IGNORE
		textureRect.mouse_default_cursor_shape = Control.CURSOR_ARROW

