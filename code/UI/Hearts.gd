extends Node2D

# node ref
@onready var heart_sprite = $Sprite2D

# this will set the heart_sprite's frame to represent the player's current health
func _on_health_updated(current_health):
	heart_sprite.vframes = 4 - current_health # 4 is the total health
