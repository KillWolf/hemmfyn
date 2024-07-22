extends Resource

class_name Inventory

@export var items: Array[InventoryItem]

var itemInHandIndex: int = -1

func insert(item: InventoryItem):
	# Find the first null value in the items array and insert item.
	var empty_slot: int = items.find(null)

	if empty_slot == -1:
		print("Too many items to find in the inventory. This should never happen")

	items[empty_slot] = item
	Signalbus.updated.emit()

func removeItemAtIndex(index: int):
	# Should this be InventoryItem.new?
	items[index] = null

	Signalbus.updated.emit()

func insertSlot(index: int, inventoryItem: InventoryItem):
	var oldIndex: int = items.find(inventoryItem)
	removeItemAtIndex(oldIndex)

	items[index] = inventoryItem

	Signalbus.updated.emit()

func transformItem(inventory_item: InventoryItem, item_path_to: String):
	var item_path = "res://inventory/items/" + item_path_to
	var newItem = load(item_path)
	var oldIndex: int = items.find(inventory_item)

	items[oldIndex] = newItem

	Signalbus.updated.emit()

