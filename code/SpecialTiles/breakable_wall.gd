extends StaticBody2D

signal health_changed

func _ready():
	health_changed.connect(_on_health_changed)

var current_health = 1:
	set(value):
		current_health = value
		health_changed.emit()

func _on_projectile_detector_area_entered(area):
	if area.is_in_group("Projectiles"):
		current_health -= 1

func _on_health_changed():
	if current_health <= 0:
		queue_free()
