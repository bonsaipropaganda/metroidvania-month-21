extends State

func enter():
	target.has_ended_jump = false
	target.get_node("AnimatedSprite2D").play("default")
	target.get_node("Timers/CoyoteTimer").stop()

	target.velocity.y = -target.jump_velocity

func update(delta):
	if !Input.is_action_pressed("jump") and not target.has_ended_jump:
		target.velocity.y /= 2
		target.has_ended_jump = true
	
	target.move(delta)

func exit():
	pass

func try_transition():
	if target.is_on_floor():
		return get_node("../Grounded")
	if target.has_ended_jump or target.velocity.y > 0: # or velocity is downward
		return get_node("../Fall")
