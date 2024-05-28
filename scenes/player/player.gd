extends CharacterBody2D

var speed: int = 300
var click_position: Vector2 = Vector2()
var target_position: Vector2
var can_move: bool = true

# MOVE ALL CLICK INTERACTION OUT AND UP
func _ready():
	Signalbus.connect("player_stop", stop)
	
func move(mouse_position:):
	target_position = mouse_position

func stop():
	target_position = position
	
func _physics_process(_delta):
	velocity = position.direction_to(target_position) * speed
	
	if position.distance_to(target_position) > 10:
		move_and_slide()
