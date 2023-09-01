extends Node


func use_hp_potion():
	print("hp potion was successfuly used")

func action(item_name):
	print("player clicked on " + str(item_name))
	if item_name in item_actions:
		item_actions[item_name].call()

# these are functions related to items from the inventory
# the key has to be the name of the item as signaled by the inventory slot
var item_actions = {"HealthPotion": use_hp_potion}
