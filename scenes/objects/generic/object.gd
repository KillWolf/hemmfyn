extends StaticBody2D

@export var dialogue_key = ""

var allow_hover: bool = false
var is_hovering: bool = false

func _ready():
	pass #  Signalbus.connect('can_hover', enable_hover)

func toggle_hover(toggle):
	allow_hover = toggle

func _on_mouse_entered():
	is_hovering = true

func _on_mouse_exited():
	is_hovering = false

func _on_input_event(_viewport, event, _shape_idx):
	if allow_hover && event.is_action_pressed("left_click"):
		Signalbus.emit_signal("display_dialogue", dialogue_key)

func _process(_delta):
	if allow_hover && is_hovering:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
