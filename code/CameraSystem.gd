extends Camera2D

var current_room = null

func _ready():
	Global.room_changed.connect(on_room_changed)

func _physics_process(_delta):
	var p = Global.get_player()
	if p:
		global_position = p.global_position

func set_camera_limits(room_shape):
	var room_size = room_shape.shape.extents * 2
	limit_left = room_shape.global_position.x - room_size.x / 2
	limit_top = room_shape.global_position.y - room_size.y / 2
	limit_right = limit_left + room_size.x
	limit_bottom = limit_top + room_size.y

func on_room_changed(room):
	if current_room == null:
		set_camera_limits(room.get_node("CollisionShape2D"))
		reset_smoothing()
	elif room != current_room:
		set_camera_limits(room.get_node("CollisionShape2D"))
		
		get_tree().paused = true
		await get_tree().create_timer(0.5).timeout
		for p in get_tree().get_nodes_in_group("projectile"):
			if is_instance_valid(p):
				p.queue_free()
		get_tree().paused = false
	
	current_room = room
