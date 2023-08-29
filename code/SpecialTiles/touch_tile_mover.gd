@tool
extends TileMap
class_name TileMover

@export var to_offset = Vector2(-500, 0)
@export var max_speed = 50
@export var accel = 1

var speed = 0
var start_pos : Vector2
var touching = false

func _ready():
	if !Engine.is_editor_hint():
		start_pos = position
		await get_tree().physics_frame
		position = start_pos # I hate godot

var prev_touching = false
func _physics_process(delta):
	if !Engine.is_editor_hint():
		if touching:
			speed = min(speed + accel, max_speed)
			var tmp = Vector2.ZERO
			tmp.x = move_toward(position.x, start_pos.x + to_offset.x, abs(speed * delta))
			tmp.y = move_toward(position.y, start_pos.y + to_offset.y, abs(speed * delta))
			position = tmp # I hate godot
			touching = false
			prev_touching = true
		else:
			if prev_touching == true:
				speed = 0
			
			speed = min(speed + accel, max_speed)
			var tmp = Vector2.ZERO
			tmp.x = move_toward(position.x, start_pos.x, speed * delta)
			tmp.y = move_toward(position.y, start_pos.y, speed * delta)
			position = tmp # I hate godot
			prev_touching = false

func _draw():
	if Engine.is_editor_hint():
		draw_line(Vector2.ZERO ,to_offset, Color(1,1,1))

func _process(delta):
	queue_redraw()
