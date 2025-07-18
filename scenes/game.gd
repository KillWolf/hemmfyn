extends Node2D

const MAIN_MENU_SCENE = preload("res://scenes/ui/menu/menu.tscn")
const MENU_OVERLAY = preload("res://scenes/ui/menu/menu_overlay.tscn")

var menu_instance: Control = null
# TODO: Not sure this is needed.
var current_room: Node = null

func _ready():
	# instance the menu and put it under UIRoot
	menu_instance = MAIN_MENU_SCENE.instantiate()
	$WorldUI.add_child(menu_instance)
	# connect its “start” signal
	Signalbus.connect("game_start", on_start_game)

func on_start_game():
	menu_instance.queue_free()
	menu_instance = null

	var menu_overlay_instance = MENU_OVERLAY.instantiate()
	$WorldUI.add_child(menu_overlay_instance)

	load_room("res://scenes/levels/office/office.tscn")

func load_room(path: String):
	if current_room:
		current_room.queue_free()
	var packed_scene = load(path)
	current_room = packed_scene.instantiate()
	$WorldRoot.add_child(current_room)
