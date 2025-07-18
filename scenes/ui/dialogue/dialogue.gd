extends CanvasLayer

@export_file("*.json") var scene_text_file

var scene_text = {}
var selected_text = []
var in_progress = false

@onready var background = $Background
@onready var dialogue_text = $Background/DialogueText

# Called when the node enters the scene tree for the first time.
func _ready():
	# Making sure that a dialogue file has been set.
	if !scene_text_file:
		push_error("scene_text_file is not set for this location.")
		return

	background.visible = false
	scene_text = load_scene_text()
	Signalbus.connect('display_dialogue', display_dialogue)

func load_scene_text():
	var file = FileAccess.get_file_as_string(scene_text_file)
	return JSON.parse_string(file)

func show_text():
	dialogue_text.text = selected_text.pop_front()

# We don't really need this right now, but maybe for a monologue?
#func next_line():
	#if selected_text.size() > 0:
		#show_text()
		#finish()
	#else:
		#scene_text = load_scene_text()
		#finish()

func finish():
	dialogue_text.text = ""
	background.visible = false
	in_progress = false
	if selected_text.size() == 0:
		scene_text = load_scene_text()
	get_tree().paused = false

# We don't really need this right now, but maybe for a monologue?
#func finish():
	#dialogue_text.text = ""
	#background.visible = false
	#in_progress = false
	#get_tree().paused = false

func display_dialogue(text_key):
	Signalbus.emit_signal("player_stop")
	get_tree().paused = true
	background.visible = true
	in_progress = true
	selected_text = scene_text[text_key]
	show_text()

func _on_button_pressed():
	finish()
