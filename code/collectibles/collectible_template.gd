extends Area2D

var player_inventory = preload("res://inventory/player_inventory.tres")

# item resources
var health_potion = preload("res://inventory/items/health_potion.tres")
var item_resources = [health_potion]


func _on_body_entered(body):
	if body.name == "Player":
		# appends the resource of the same name as the collectible scene
		# to the player's inventory resource
		for resource in item_resources:
			if self.name == resource.name:
				player_inventory.items.append(resource)
				queue_free()
