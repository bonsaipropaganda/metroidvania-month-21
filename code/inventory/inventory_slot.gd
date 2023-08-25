extends Panel

# this is a reference to the corrosponding item
var reference_to_item

func update(item: InventoryItem):
	if !item:
		$Background.frame = 0
		$CenterContainer/Item.visible = false
	else:
		$Background.frame = 1
		$CenterContainer/Item.visible
		$CenterContainer/Item.texture = item.texture
		reference_to_item = item


func _on_button_pressed():
	if reference_to_item:
		ActionManager.action(reference_to_item.name)
