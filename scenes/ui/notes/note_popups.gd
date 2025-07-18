extends PopupPanel

# Buttons
@onready var close_button : Button = $Control/MarginContainer/VBoxContainer/Button

func _ready():
	# Signals
	close_button.connect("pressed", _hide)

func open(_text):
	pass
	# set text for richtext_l albve
	#popup_centered()

func _hide():
	self.hide()
