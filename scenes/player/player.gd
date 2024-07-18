extends CharacterBody2D

var speed: int = 200
var acceleration: int = 20
var target_position: Vector2
var destination: Vector2

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	Signalbus.connect("player_stop", stop)

func move(mouse_position:):
	navigation_agent.target_position = mouse_position
	target_position = mouse_position

func stop():
	target_position = position

func _physics_process(delta):
	var direction = to_local(navigation_agent.get_next_path_position()).normalized()
	velocity = velocity.lerp(direction * speed, acceleration * delta)


	if position.distance_to(target_position) > 10:
		move_and_slide()

