extends Node2D

@onready var player = $Player
#@onready var animation = $AnimationPlayer

func _ready():
	# Signalbus connection
	Signalbus.connect("pause_toggled", on_pause_toggled)

	# Setting player start position
	player.position = Vector2(470, 944)
	# Setting the dialogue JSON for Office
	#%Dialogue.scene_text_file = "res://assets/json/office/object_dialogue.json"

	#$AnimationPlayer.play("computer_light")
	#var anim = $AnimationPlayer.get_animation("computer_light")
	#anim.loop = true

	#$AudioStreamPlayer2D.play()
#	player.target_position = Vector2(1506, 744)
	# TODO: Should be played shortly after the menu disappears
	#await get_tree().create_timer(2).timeout
	#$AnimationPlayer.play("brev")

	#await get_tree().create_timer(2).timeout
	#animation.play("letter")

func _on_floor_input_event(_viewport, event, _shape_idx):
	pass
	#if event is InputEventMouseButton && event.is_action_pressed("left_click"):
		#player.move(event.position)

func _unhandled_input(event) -> void:
	if event is InputEventMouseButton and event.pressed and event.is_action_pressed("left_click"):
		# only runs if no one else accepted it
		player.move(event.position)

# DOOR CLICK
# TODO: FIX. Does not look like it's working because it's missing an area.
func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("left_click"):
		get_tree().change_scene_to_file("res://scenes/cutscene/intro_cutscene.tscn")

func on_pause_toggled():
	pass
	#if GameState.is_paused():
		#animation.pause()
	#else:
	#	if animation.current_animation_position < animation.current_animation_length:
	#		animation.play()
