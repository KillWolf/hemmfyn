extends Resource

class_name Inventory

signal update

@export var slots: Array[InventorySlot]

func insert(item: InventoryItem):
	var emptyslots = slots.filter(func(slot): return slot.item == null)
	if !emptyslots.is_empty():
		emptyslots[0].item = item
	update.emit()
