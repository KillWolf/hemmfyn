extends TextureRect

var dragging: bool = false

func _process(_delta):
	if dragging:
		var mousepos = get_viewport().get_mouse_position()
		self.position = Vector2(mousepos.x, mousepos.y)

func _on_gui_input(event):
	print("LOL")
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			dragging = true
		elif event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			dragging = false

func _on_mouse_entered():
	print("YOU SUNNEVA PITCH")
