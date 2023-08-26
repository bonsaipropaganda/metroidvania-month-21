extends State

func enter():
	target.get_node("AnimatedSprite2D").play("default")

func update(delta):
	target.get_node("Timers/CoyoteTimer").start(target.coyote_time)
	target.move(delta)

func exit():
	pass

func try_transition():
	if transitions.to_jump():
		return get_node("../Jump")
