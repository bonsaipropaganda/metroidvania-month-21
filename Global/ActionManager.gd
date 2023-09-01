extends Node

@onready var player_inventory = preload("res://code/inventory/player_inventory.tres")

func use_hp_potion():
	Global.update_player_health.emit(4)

func action(item,consumable):
	if item.name in item_actions:
		item_actions[item.name].call()
	if consumable:
		player_inventory.items.erase(item)
		Global.inventory_updated.emit()


# these are functions related to items from the inventory
# the key has to be the name of the item as signaled by the inventory slot
var item_actions = {"HealthPotion": use_hp_potion}
