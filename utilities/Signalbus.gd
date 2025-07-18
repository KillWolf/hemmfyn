extends Node

# Dialogue
signal display_dialogue(text_key)

# Objects
# We won't use this for now
#signal object_was_clicked()
signal can_hover(bool_key, area_name)

# Player
signal player_stop()

# Inventory
signal collect_item(item: InventoryItem)
signal updated
signal update_item_in_hand
signal transform_item_in_hand

# Menu
signal game_start

# Gamestate
signal pause_toggled
