extends Control

# Begin new game scene
@onready var office_scene = preload("res://scenes/levels/office/office.tscn")

# Buttons
@onready var button_new : Button = $VBoxContainer/NewGame
@onready var button_continue : Button = $VBoxContainer/Continue
@onready var button_load : Button = $VBoxContainer/Load
@onready var button_quit : Button = $VBoxContainer/Quit

# Other
@onready var buttons_container : VBoxContainer = $VBoxContainer
@onready var color_rect : ColorRect = $ColorRect

func _ready():
	# Menu button interactions
	button_new.connect("pressed", _on_new_pressed)
	button_quit.connect("pressed", _on_quit_pressed)

	# The continue button should only present, when a save game is available.
	button_continue.visible = false

func _on_new_pressed():
	# TODO: CREATE SAVE GAME!

	# TODO: Should also be included for loading
	GameState.start_game()

func load():
	pass

func _on_quit_pressed():
	# TODO: We probably should warn that quitting unsaved
	# TODO: will resolve in lost data
	get_tree().quit()
