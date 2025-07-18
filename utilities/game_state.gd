extends Node

enum State { PLAYING, PAUSED }

@export var current_state: State = State.PLAYING

func _ready():
	# Process mode
	process_mode = Node.PROCESS_MODE_ALWAYS

func start_game():
	Signalbus.emit_signal("game_start")

func _input(event):
	if event.is_action_pressed("toggle_menu") && GameState.game_started():
		toggle_pause()

func toggle_pause():
	if current_state == State.PLAYING:
		current_state = State.PAUSED
		Signalbus.emit_signal("pause_toggled")
		get_tree().paused = true
	elif current_state == State.PAUSED:
		current_state = State.PLAYING
		Signalbus.emit_signal("pause_toggled")
		get_tree().paused = false

func game_started():
	return current_state in [State.PLAYING, State.PAUSED]

func is_paused():
	return current_state == State.PAUSED
