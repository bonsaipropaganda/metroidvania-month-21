extends Node


func heal():
	Global.player_health = 5

func action(reference_to_item):
	print("player used " + str(reference_to_item) + " ,but nothing happened because we haven't coded actions yet. \n See the ActionManger autoload for more details.")

