extends Control

var isOpen: bool = false

@onready var inventory: Inventory = preload("res://inventory/player_inventory.tres")
@onready var ItemGuiClass = preload("res://inventory/item_gui.tscn")
@onready var slots: Array = $ColorRect/GridContainer.get_children()

@onready var itemInHand: ItemGui

func _ready():
	connectSlots()
	Signalbus.collect_item.connect(collect_item)
	Signalbus.updated.connect(update)
	Signalbus.transform_item_in_hand.connect(transformItemInHand)
	Signalbus.toggle_inventory.connect(open)
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
	# Only allow the player to close the inventory
	# if they do no have a item in hand.
	if !itemInHand:
		visible = false
		isOpen = false

func transformItemInHand():
	# Using JSON to look up the correct name programatically
	var lookup = load_lookup_json()
	# Let's gracefully return if lookup_object was not found
	if !lookup.has(itemInHand.inventoryItem.name): return

	# Removing the items to make room for the transformed object
	inventory.removeItemAtIndex(inventory.items.find(itemInHand.inventoryItem))
	remove_child(itemInHand)

	# This is for the tutorial


	# Creating the inventoryItem
	var new_inventory_item = InventoryItem.new()

	new_inventory_item.name = lookup[itemInHand.inventoryItem.name]["name"]
	var texture = load("res://graphics/inventory_items/" + lookup[itemInHand.inventoryItem.name]["image"])
	new_inventory_item.texture = texture

	# Instantiating the itemGui scene
	var item_gui_scene = preload("res://inventory/item_gui.tscn")
	var new_item = item_gui_scene.instantiate()

	new_item.inventoryItem = new_inventory_item

	itemInHand = new_item
	add_child(itemInHand)

	# Updating the new_item after adding it to the scene, otherwise it won't work
	# The different attributes will not have been loaded before.
	new_item.update()

	updateItemInHand()

func onSlotClicked(slot):
	if slot.isEmpty():
		if !itemInHand: return

		insertItemInSlot(slot)
		Signalbus.update_item_in_hand.emit()
		return

	if !itemInHand:
		takeItemFromSlot(slot)
		Signalbus.update_item_in_hand.emit()
		return

	# Do we need swap?
	swapItems(slot)

func takeItemFromSlot(slot):
	itemInHand = slot.takeItem()
	add_child(itemInHand)
	updateItemInHand()

func insertItemInSlot(slot):
	var item = itemInHand

	remove_child(itemInHand)
	itemInHand = null

	slot.insert(item)

func swapItems(slot):
	var tempItem = slot.takeItem()

	insertItemInSlot(slot)

	itemInHand = tempItem
	add_child(itemInHand)

	updateItemInHand()

func updateItemInHand():
	if !itemInHand: return
	itemInHand.global_position = get_global_mouse_position()

func load_lookup_json():
	var file = FileAccess.get_file_as_string("res://assets/json/general/object_transform_lookup.json")
	return JSON.parse_string(file)

func _input(_event):
	updateItemInHand()
