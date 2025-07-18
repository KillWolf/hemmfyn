extends Node2D

# Conditions
@onready var allow_hover : bool = false
@onready var is_hovering : bool = false

func _on_interaction_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if (event is InputEventMouseButton and event.pressed && allow_hover && is_hovering):
		var popup = preload("res://scenes/ui/notes/note_popups.tscn").instantiate()
		popup.open("example text")
		get_tree().root.get_node("Game").get_node("WorldUI").add_child(popup)

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
