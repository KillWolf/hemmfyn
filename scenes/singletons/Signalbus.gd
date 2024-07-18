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
