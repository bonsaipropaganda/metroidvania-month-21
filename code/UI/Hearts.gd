extends Node2D

# node ref
@onready var heart_sprite = $Sprite2D

func _ready():
	Global.update_health_ui.connect(_on_health_updated)

# this will set the heart_sprite's frame to represent the player's current health
func _on_health_updated(current_health):
	heart_sprite.frame = 4 - current_health # 4 is the total health
