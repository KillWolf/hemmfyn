extends Panel

class_name ItemGui

@onready var itemSprite: Sprite2D = $item

var inventoryItem: InventoryItem

func update():
	if inventoryItem:
		itemSprite.visible = true
		itemSprite.texture = inventoryItem.texture
