extends State

func enter():
	target.has_ended_jump = false
	target.get_node("Sprite").play("default")
	target.get_node("Timers/CoyoteTimer").stop()

	target.velocity.y = min(-target.jump_velocity, target.velocity.y)

func update(delta):
	if !Input.is_action_pressed("jump") and not target.has_ended_jump:
		target.velocity.y /= 2
		target.has_ended_jump = true
	
	target.move(delta)

func exit():
	pass

func try_transition():
	if transitions.to_grapple():
		return get_node("../Grapple")
	if target.is_on_floor():
		return get_node("../Grounded")
	if target.has_ended_jump or target.velocity.y > 0: # or velocity is downward
		return get_node("../Fall")
