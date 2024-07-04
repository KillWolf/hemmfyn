extends Control

@onready var inventory: Inventory = preload("res://inventory/inventory.tres")
@onready var slots: Array = $ColorRect/GridContainer.get_children()

var is_open: bool = false

func _ready():
	Signalbus.connect('collect_item', collect_item)
	inventory.update.connect(update_slots)
	update_slots()
	close()

func collect_item(item):
	inventory.insert(item)

func update_slots():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])

func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false

func _process(_delta):
	if Input.is_action_just_pressed("toggle_inventory"):
		if is_open:
			close()
		else:
			open()
