extends Node2D
class_name LevelParent

@onready var computer = $ComputerTable
var node_was_clicked = false
	#
#func _physics_process(_delta):
	#if Input.is_action_just_pressed("left_click"):
		#handle_click()
#
#func handle_click():
	#if !node_was_clicked:
		#$Player.move(get_global_mouse_position())
	#
