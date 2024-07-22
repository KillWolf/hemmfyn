extends CharacterBody2D

var speed: int = 200
var acceleration: int = 20
var target_position: Vector2
var destination: Vector2

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var item_in_hand: bool = false
@onready var inventory_area_active: bool = false
@onready var inventory: Inventory = preload("res://inventory/player_inventory.tres")

func _ready():
	Signalbus.update_item_in_hand.connect(update_item_in_hand)
	Signalbus.connect("player_stop", stop)

func move(mouse_position:):
	if !item_in_hand:
		navigation_agent.target_position = mouse_position
		target_position = mouse_position

func stop():
	target_position = position

func update_item_in_hand():
	item_in_hand = !item_in_hand

func _on_inventory_interaction_area_area_entered(area):
	# This should probably be from a look-up table instead of just a hardcoded string
	if area.name == "InventoryItem":
		inventory_area_active = true

func _on_inventory_interaction_area_area_exited(area):
	# This should probably be from a look-up table instead of just a hardcoded string
	if area.name == "InventoryItem":
		inventory_area_active = false

func _on_inventory_interaction_area_input_event(_viewport, event, _shape_idx):
	if inventory_area_active && event.is_action_pressed("left_click"):
		Signalbus.transform_item_in_hand.emit()

func _physics_process(delta):
	var direction = to_local(navigation_agent.get_next_path_position()).normalized()
	velocity = velocity.lerp(direction * speed, acceleration * delta)
#
	if position.distance_to(target_position) > 10:
		move_and_slide()
