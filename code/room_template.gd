extends TileMap



func _on_body_entered(body):
	if body.name == "Player":
		Global.current_room = self
		Global.room_changed.emit(self)
