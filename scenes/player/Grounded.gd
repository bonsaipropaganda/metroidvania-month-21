extends State

var safe_frame_count = 0
func enter():
	target.get_node("Sprite").play("default")
	safe_frame_count = 1

func update(delta):
	target.get_node("Timers/CoyoteTimer").start(target.coyote_time)
	target.move(delta)
	
	var sr = Global.get_spike_respawner()
	var col = target.get_node("FloorRayCast").get_collider()

	if sr and col and col.is_in_group("main_tilemap")\
		and !target.get_node("DamageHurtbox").i_timer.time_left:
			safe_frame_count += 1
	else:
		safe_frame_count = 0
	if safe_frame_count > 1:
		sr.global_position = target.global_position

func exit():
	pass

func try_transition():
	if transitions.to_grapple():
		return get_node("../Grapple")
	if transitions.to_jump():
		return get_node("../Jump")
	if !target.is_on_floor() && target.velocity.y > 0:
		return get_node("../Fall")
