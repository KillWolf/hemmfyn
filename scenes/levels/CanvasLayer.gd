extends CanvasLayer

@onready var inventory = $InventoryGui
@onready var tutorial_ongoing = false

func _ready():
	inventory.close()
	Signalbus.tutorial_started.connect(tutorial_started)
	Signalbus.tutorial_ended.connect(tutorial_ended)

func _input(event):
	if !tutorial_ongoing && event.is_action_pressed("toggle_inventory"):
		if inventory.isOpen:
			inventory.close()
		else:
			inventory.open()

func tutorial_started():
	tutorial_ongoing = true

func tutorial_ended():
	tutorial_ongoing = false
