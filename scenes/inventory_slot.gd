extends Panel

func update(item: InventoryItem):
	if !item:
		$Background.frame = 0
		$CenterContainer/Item.visible = false
	else:
		$Background.frame = 1
		$CenterContainer/Item.visible
		$CenterContainer/Item.texture = item.texture
