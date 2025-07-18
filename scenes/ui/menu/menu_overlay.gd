extends CanvasLayer

# Animation
@onready var animation : AnimationPlayer = $Control/AnimationPlayer

# Buttons
@onready var button_continue : Button = $Control/VBoxContainer/Button4
@onready var button_quit : Button = $Control/VBoxContainer/Button3

# Other
@onready var buttons_container : VBoxContainer = $Control/VBoxContainer
@onready var menu_overlay : CanvasLayer = self
@onready var color_rect : ColorRect = $Control/ColorRect

func _ready():
	# Process mode
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

	# Menu button interactions
	button_continue.connect("pressed", _on_continue_pressed)

	# Signalbus
	Signalbus.connect("pause_toggled", on_pause_toggled)

	menu_overlay.visible = false

func _on_continue_pressed():
	GameState.toggle_pause()

# TODO: Should probably lead to main menu
# button_quit.connect("pressed", _on_quit_pressed) # Move to ready when reenabled
#func _on_quit_pressed():
	## TODO: We probably should warn that quitting unsaved
	## TODO: will resolve in lost data
	#get_tree().quit()

# Signal methods
func on_pause_toggled():
	menu_overlay.visible = GameState.is_paused()
