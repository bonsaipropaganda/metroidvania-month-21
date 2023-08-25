extends CanvasLayer

# node refs
@onready var inventory = $Inventory

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		if inventory.is_open:
			inventory.close()
		else: 
			inventory.update()
			inventory.open()
