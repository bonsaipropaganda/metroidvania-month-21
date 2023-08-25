extends Area2D
class_name CollectibleTemplate

var player_inventory = preload("res://code/inventory/player_inventory.tres")

# item resources
var health_potion = preload("res://code/inventory/items/health_potion.tres")
var item_resources = [health_potion]


func _on_body_entered(body):
	if body.name == "Player":
		# appends the resource of the same name as the collectible scene
		# to the player's inventory resource
		for resource in item_resources:
			if self.name == resource.name:
				player_inventory.items.append(resource)
				queue_free()
