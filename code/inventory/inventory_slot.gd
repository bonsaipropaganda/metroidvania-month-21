extends Panel

# this is a reference to the corrosponding item
var reference_to_item

func update(item: InventoryItem):
	if item:
		$Background.frame = 1
		$CenterContainer/Item.visible = true
		$CenterContainer/Item.texture = item.texture
		reference_to_item = item
	else:
		print("no item here")
		$Background.frame = 0
		$CenterContainer/Item.visible = false

func remove_item():
	$Background.frame = 0
	$CenterContainer/Item.visible = false
	reference_to_item = null


func _on_button_pressed():
	if reference_to_item:
		# the true here indicates it is a consumable
		ActionManager.action(reference_to_item,true)
