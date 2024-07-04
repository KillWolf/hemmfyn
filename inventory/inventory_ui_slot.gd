extends Panel

@onready var item_sprite: Sprite2D = $CenterContainer/TextureRect/item
@onready var texture_rect: TextureRect = $CenterContainer/TextureRect
@onready var center_container: CenterContainer = $CenterContainer
var dragging: bool = false
var start_position: Vector2
var start_zindex: int
# A hackish way to offset the size of the item container
var item_offset_x: int = 80
var item_offset_y: int = 80

func _ready():
	start_position = center_container.position
	start_zindex = center_container.z_index

func update(slot: InventorySlot):
	if !slot.item:
		item_sprite.visible = false
	else:
		item_sprite.visible = true
		item_sprite.texture = slot.item.texture

func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			dragging = true
		elif event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			dragging = false

func _process(_delta):
	if dragging:
		var mousepos = get_viewport().get_mouse_position()
		center_container.position = Vector2(mousepos.x - item_offset_x, mousepos.y - item_offset_y)
		center_container.z_index = 100
	else:
		center_container.position = start_position
		center_container.z_index = start_zindex
