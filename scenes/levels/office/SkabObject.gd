extends StaticBody2D

var is_hovering: bool = false
var allow_hover: bool = false

@onready var textureRect: TextureRect = $"../TextureRect"

func _on_mouse_entered():
	is_hovering = true

func _on_mouse_exited():
	is_hovering = false

func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		allow_hover = true

func _on_area_2d_body_exited(_body):
	allow_hover = false

func _process(_delta):
	if is_hovering && allow_hover:
		textureRect.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	else:
		textureRect.mouse_default_cursor_shape = Control.CURSOR_ARROW
