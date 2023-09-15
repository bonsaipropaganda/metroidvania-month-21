extends State

func enter():
	target.get_node("Timer").start(7)
	jump()

func jump():
	var p = Global.get_player()
	var dir = 0
	if p:
		dir = sign(p.global_position.x - target.global_position.x)
	target.velocity.y = -600
	target.velocity.x = dir * 200

func update(_delta):
	if target.is_on_floor():
		jump()

func exit():
	pass

func try_transition() -> State:
	if target.get_node("Timer").time_left == 0:
		return get_node("../Idle")
	return null
