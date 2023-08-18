extends Area2D

# node refs
@onready var player = $"../Player"

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		if player.velocity.x >= 0:
			self.global_position.x += get_viewport_rect().size.x
		elif player.velocity.x <= 0:
			self.global_position.x -= get_viewport_rect().size.x
#		elif player.velocity.
