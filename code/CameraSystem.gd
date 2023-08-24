extends Camera2D

func _ready():
	Global.room_changed.connect(on_room_changed)

func on_room_changed(room:TileMap):
	#using a tween to change the position
	var tween:Tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", room.global_position, 1)
