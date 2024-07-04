extends StaticBody2D

@export var dialogue_key = ""

var area_active: bool = false
var mouse_entered_object: bool = false

func _ready():
	Signalbus.connect('can_hover', enable_hover)
	# This might be used?
	#Signalbus.connect('object_was_clicked', )

func _on_mouse_entered():
	mouse_entered_object = true

func _on_mouse_exited():
	mouse_entered_object = false

func enable_hover(bool_key):
	area_active = bool_key

func _on_input_event(_viewport, event, _shape_idx):
	if area_active && event.is_action_pressed("left_click"):
		Signalbus.emit_signal("display_dialogue", dialogue_key)

func _physics_process(_delta):
	if area_active && mouse_entered_object:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
