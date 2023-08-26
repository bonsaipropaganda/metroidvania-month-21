extends State

func enter():
	target.get_node("AnimatedSprite2D").play("default")
	target.get_node("Timers/CoyoteTimer").start(target.coyote_time)

func update(delta):
	target.move(delta)
	target.action_manager()

func exit():
	pass

func try_transition():
	if Input.is_action_just_pressed("jump"):
		return get_node("../Jump")
