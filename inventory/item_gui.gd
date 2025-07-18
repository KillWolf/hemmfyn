extends Panel

class_name ItemGui

@onready var itemSprite: Sprite2D = $item
@onready var collisionShape: CollisionShape2D = $InventoryItem/CollisionShape2D

var inventoryItem: InventoryItem
#
#func _ready():
	## Optionally, you can perform initial setup here if needed
	#update()

func update():
	if inventoryItem:
		itemSprite.visible = true
		itemSprite.texture = inventoryItem.texture

		var new_shape = CircleShape2D.new()
		new_shape.radius = itemSprite.texture.get_size().x
		collisionShape.shape = new_shape
