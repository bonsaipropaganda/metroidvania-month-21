extends Area2D

var player_present = false

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_present = true
		Global.update_player_health.emit(4)

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_present = false

func _process(delta):
	if player_present:
		if Input.is_action_just_pressed("action"):
			set_checkpoint()

func set_checkpoint():
	Global.player_checkpoint = self.global_position
	Global.update_player_health.emit(4)
