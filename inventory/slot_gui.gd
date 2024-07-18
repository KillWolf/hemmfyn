extends Button

@onready var backgroundColor: ColorRect = $ColorRect
@onready var container: CenterContainer = $CenterContainer

@onready var inventory: Inventory = preload("res://inventory/player_inventory.tres")

var itemGui: ItemGui
var index: int

func insert(ig: ItemGui):
	itemGui = ig
	container.add_child(itemGui)

	if !itemGui.inventoryItem || inventory.items[index] == itemGui.inventoryItem:
		return

	inventory.insertSlot(index, itemGui.inventoryItem)

func takeItem():
	var item = itemGui

	container.remove_child(itemGui)
	itemGui = null

	return item

func isEmpty():
	return !itemGui
