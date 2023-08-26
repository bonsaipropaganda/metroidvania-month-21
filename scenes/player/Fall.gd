extends State

func enter():
	target.get_node("AnimatedSprite2D").play("default")

func try_buffer_inputs():
	if Input.is_action_just_pressed("jump"):
		target.get_node("Timers/BufferJumpTimer").start(0.2)

func update(delta):
	try_buffer_inputs()
	target.move(delta)

func exit():
	pass

func try_transition():
	if target.is_on_floor():
		return get_node("../Grounded")
	if target.velocity.y > 0:
		return get_node("../Fall")
