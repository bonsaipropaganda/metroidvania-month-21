extends Area2D
var active = false

func set_checkpoint():
	active = true
	Global.player_checkpoint = self.global_position
	Global.update_player_health.emit(4)
	$SetCheckpoint.visible = true
	$UnsetCheckpoint.visible = false
	
	for f in get_tree().get_nodes_in_group("checkpoint"):
		if f != self:
			f.unset_checkpoint()

func unset_checkpoint():
	active = false
	$SetCheckpoint.visible = false
	$UnsetCheckpoint.visible = true

func action():
	if !active:
		set_checkpoint()
