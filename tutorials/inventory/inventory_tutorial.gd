extends Control

@onready var border_panel: Panel = $Panel
@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	border_panel.visible = false
	label.visible = false
	Signalbus.tutorial_started.connect(tutorial_started)
	Signalbus.tutorial_ended.connect(tutorial_ended)

func tutorial_started():
	Signalbus.open_inventory.emit()
	border_panel.visible = true
	label.visible = true

func tutorial_ended():
	border_panel.visible = false
	label.visible = false



