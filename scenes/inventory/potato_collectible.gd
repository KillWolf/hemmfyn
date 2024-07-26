extends Node2D

@export var item = InventoryItem
@onready var textureRect: TextureRect = $TextureRect

var allow_hover: bool = false
var is_hovering: bool = false

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if allow_hover && event.is_action_pressed("left_click"):
		Signalbus.collect_item.emit(item)
		Signalbus.tutorial.emit()
		self.queue_free()

func _on_area_entered_body_entered(body):
	if body is CharacterBody2D:
		allow_hover = true

func _on_area_entered_body_exited(body):
	if body is CharacterBody2D:
		allow_hover = false

func _on_interactable_area_mouse_entered():
	is_hovering = true

func _on_interactable_area_mouse_exited():
	is_hovering = false

func _process(_delta):
	if is_hovering && allow_hover:
		textureRect.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	else:
		textureRect.mouse_default_cursor_shape = Control.CURSOR_ARROW
