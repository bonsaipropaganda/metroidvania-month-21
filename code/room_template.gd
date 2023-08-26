extends Area2D

const MIN_ROOM_WIDTH = 640
const MIN_ROOM_HEIGHT = 360

const UP_TRANSITION_BOOST = -400

func _ready():
	if ($CollisionShape2D.position != Vector2.ZERO):
		push_error("Room [" + name + "]'s collision shape has an offset. Please move it to position (0,0)")
	if ($CollisionShape2D.shape.size.x < MIN_ROOM_WIDTH):
		push_error("Room [" + name + "]'s width is smaller than the minimum")
	if ($CollisionShape2D.shape.size.y < MIN_ROOM_HEIGHT):
		push_error("Room [" + name + "]'s height is smaller than the minimum")

func _on_body_entered(body):
	if body.is_in_group("player"):
		Global.current_room = self
		Global.room_changed.emit(self)
		snap_player_to_room()

const snap_fatness = 20
const snap_up_height = 50
const snap_down_height = 50
func snap_player_to_room():
	if Global.get_player().global_position.x - snap_fatness < Global.get_cam().limit_left:
		Global.get_player().global_position.x = Global.get_cam().limit_left + snap_fatness
	elif Global.get_player().global_position.x + snap_fatness > Global.get_cam().limit_right:
		Global.get_player().global_position.x = Global.get_cam().limit_right - snap_fatness
	
	if Global.get_player().global_position.y - snap_down_height < Global.get_cam().limit_top:
		Global.get_player().global_position.y = Global.get_cam().limit_top + snap_down_height
	elif Global.get_player().global_position.y + snap_up_height > (Global.get_cam().limit_bottom):
		Global.get_player().global_position.y = Global.get_cam().limit_bottom - snap_up_height
		if Global.get_player().velocity.y > UP_TRANSITION_BOOST:
			Global.get_player().velocity.y = UP_TRANSITION_BOOST
			Global.get_player().has_ended_jump = true
