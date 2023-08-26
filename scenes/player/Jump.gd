extends State

func enter():
	target.get_node("AnimatedSprite2D").play("default")

	target.velocity.y = -target.jump_velocity

func update(delta):
	target.move(delta)
	target.action_manager()

func exit():
	pass

func try_transition():
	if target.is_on_floor():
		return get_node("../Grounded")
