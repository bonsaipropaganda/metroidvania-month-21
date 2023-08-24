extends Camera2D

var t = 0.0
var start_pos
var end_pos

func _ready():
	Global.room_changed.connect(on_room_changed)

func on_room_changed(room):
	start_pos = global_position
	end_pos = room.global_position
	t = 0.0
#	self.global_position = room.global_position

func _process(delta):
	if start_pos:
		if t < 1:
			t += delta * 0.4
			self.global_position = start_pos.lerp(end_pos, t)
