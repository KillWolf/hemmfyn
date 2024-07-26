extends Control

@onready var border_panel: Panel = $Panel
@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	border_panel.visible = false
	label.visible = false
	# We will probably change the name of this variable.
	Signalbus.tutorial.connect(tutorial)


func tutorial():
	Signalbus.toggle_inventory.emit()
	border_panel.visible = true
	label.visible = true



