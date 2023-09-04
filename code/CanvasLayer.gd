extends CanvasLayer

# node refs
@onready var inventory = $Inventory

func _input(event):
	if inventory.is_open and (event.is_action_pressed("toggle_inventory") or event.is_action_pressed("ui_cancel")):
		inventory.close()
	elif !inventory.is_open and event.is_action_pressed("toggle_inventory"):
			inventory.update()
			inventory.open()
