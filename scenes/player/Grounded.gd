extends State

func enter():
	target.get_node("Sprite").play("default")

func update(delta):
	target.get_node("Timers/CoyoteTimer").start(target.coyote_time)
	target.move(delta)

func exit():
	pass

func try_transition():
	if transitions.to_grapple():
		return get_node("../Grapple")
	if transitions.to_jump():
		return get_node("../Jump")
	if !target.is_on_floor() && target.velocity.y > 0:
		return get_node("../Fall")
