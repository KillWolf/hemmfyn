extends Control

var isOpen: bool = false

@onready var inventory: Inventory = preload("res://inventory/player_inventory.tres")
@onready var ItemGuiClass = preload("res://inventory/item_gui.tscn")
@onready var slots: Array = $ColorRect/GridContainer.get_children()

var itemInHand: ItemGui

func _ready():
	connectSlots()
	Signalbus.collect_item.connect(collect_item)
	Signalbus.updated.connect(update)
	update()

func connectSlots():
	for i in range(slots.size()):
		var slot = slots[i]
		slot.index = i

		var callable = Callable(onSlotClicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)

func collect_item(item):
	inventory.insert(item)

func update():
	for i in range(min(inventory.items.size(), slots.size())):
		var inventoryItem: InventoryItem = inventory.items[i]

		if !inventoryItem: continue

		var itemGui: ItemGui = slots[i].itemGui
		if !itemGui:
			itemGui = ItemGuiClass.instantiate()
			slots[i].insert(itemGui)

		itemGui.inventoryItem = inventoryItem
		itemGui.update()

func open():
	visible = true
	isOpen = true

func close():
	visible = false
	isOpen = false

func onSlotClicked(slot):
	if slot.isEmpty() && itemInHand:
		insertItemInSlot(slot)
		return

	if !itemInHand:
		takeItemFromSlot(slot)

func takeItemFromSlot(slot):
	itemInHand = slot.takeItem()
	add_child(itemInHand)
	updateItemInHand()

func insertItemInSlot(slot):
	var item = itemInHand

	remove_child(itemInHand)
	itemInHand = null

	slot.insert(item)

func updateItemInHand():
	if !itemInHand: return
	itemInHand.global_position = get_global_mouse_position()

func _input(_event):
	updateItemInHand()
